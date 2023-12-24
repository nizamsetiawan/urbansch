import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:urbanscholaria_app/constant/colors.dart';

class PermissionViewModel {
  final String hintText;
  final String subTitle;
  String? filePath;

  PermissionViewModel({
    required this.hintText,
    required this.subTitle,
    this.filePath,
  });
}

class PermissionWidget extends StatefulWidget {
  final PermissionViewModel viewModel;
  final Function(String title, String filePath) onFilePicked;

  const PermissionWidget({
    Key? key,
    required this.viewModel,
    required this.onFilePicked,
  }) : super(key: key);

  @override
  _PermissionWidgetState createState() => _PermissionWidgetState();
}

class _PermissionWidgetState extends State<PermissionWidget> {
  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        widget.viewModel.filePath = result.files.single.path!;
      });

      widget.onFilePicked(
        widget.viewModel.subTitle,
        result.files.single.path!,
      );
    } else {
      // User membatalkan pemilihan
    }
  }

  Widget _buildFileUpload() {
    return GestureDetector(
      onTap: () async {
        await _pickFile();
      },
      child: Container(
        height: 36,
        width: 256,
        decoration: BoxDecoration(
          color: appwhite,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Colors.grey,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Pilih File',
              style: TextStyle(fontSize: 10, color: appneutral500),
            ),
            VerticalDivider(
              color: appneutral300,
              thickness: 2,
            ),
            widget.viewModel.filePath != null
                ? Text(
                    '${widget.viewModel.filePath!.split('/').last}',
                    style: TextStyle(fontSize: 10, color: appneutral500),
                  )
                : Text(
                    'Belum ada file yang dipilih',
                    style: TextStyle(fontSize: 10, color: appneutral500),
                  ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.viewModel.hintText,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          Text(
            widget.viewModel.subTitle,
            style: TextStyle(fontSize: 10, color: appneutral500),
          ),
          SizedBox(height: 10),
          _buildFileUpload(), // Menggunakan widget _buildFileUpload yang telah diperbarui
        ],
      ),
    );
  }
}
