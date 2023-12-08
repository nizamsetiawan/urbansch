import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urbanscholaria_app/constant/colors.dart';
import 'package:urbanscholaria_app/controllers/chat_c.dart';
import 'package:urbanscholaria_app/models/chat_m.dart';

class ChatView extends StatelessWidget {
  final ChatController chatController = Get.put(ChatController());
  final TextEditingController messageController = TextEditingController();

  Future<void> _pickAndSendMessage() async {
    final pickedImagePath = await chatController.pickImageFromGallery();
    if (pickedImagePath != null) {
      chatController.sendImage(pickedImagePath);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbrand500,
        title: const Text("OBROLAN"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: chatController.chatList.length,
                itemBuilder: (context, index) {
                  var chat = chatController.chatList[index];
                  if (chat.imageUrl != null) {
                    return ImageBubble(
                      imagePath: chat.imageUrl!,
                      isMe: chat.isMe,
                      time: chat.time,
                    );
                  } else {
                    return MessageBubble(
                      message: chat.message!,
                      isMe: chat.isMe,
                      time: chat.time,
                    );
                  }
                },
              );
            }),
          ),
          _buildChatInput(),
        ],
      ),
    );
  }

  Widget _buildChatInput() {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  border:
                      Border.all(color: Colors.grey), // Ubah sesuai kebutuhan
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: messageController,
                        decoration: InputDecoration(
                          fillColor: appbrand100,
                          hintText: 'Tulis pesan...',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.image),
                      color: appbrand300,
                      onPressed: _pickAndSendMessage,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 8.0),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: appbrand100, // Ubah sesuai kebutuhan
              ),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  var messageText = messageController.text;
                  if (messageText.isNotEmpty) {
                    ChatMessage newMessage = ChatMessage(
                      message: messageText,
                      time: DateTime.now(),
                      isMe: true,
                    );
                    chatController.sendMessage(newMessage);
                    messageController.clear();
                  }
                },
                color: appbrand500,
              ),
            ),
          ],
        ));
  }
}

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final DateTime time;

  const MessageBubble({
    required this.message,
    required this.isMe,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        '${time.day}/${time.month}/${time.year}'; // Format tanggal
    String formattedTime = '${time.hour}:${time.minute}'; // Format waktu

    return Column(
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.all(4.0),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: isMe ? appbrand2_200 : Colors.blue,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Text(
            message,
            style: TextStyle(color: Colors.black),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$formattedDate - $formattedTime', // Tampilkan tanggal dengan format yang diinginkan
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ImageBubble extends StatelessWidget {
  final String imagePath;
  final bool isMe;
  final DateTime time;

  const ImageBubble({
    required this.imagePath,
    required this.isMe,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        '${time.day}/${time.month}/${time.year}'; // Format tanggal
    String formattedTime = '${time.hour}:${time.minute}'; // Format waktu

    return Column(
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            color: isMe ? appbrand2_200 : Colors.blue,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Image.file(
            File(imagePath),
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$formattedDate - $formattedTime', // Tampilkan tanggal dengan format yang diinginkan
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
