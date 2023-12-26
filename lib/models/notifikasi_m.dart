class NotificationModel {
  final int id;
  final int userId;
  final String judul;
  final String deskripsi;

  NotificationModel({
    required this.id,
    required this.userId,
    required this.judul,
    required this.deskripsi,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      userId: json['user_id'],
      judul: json['judul'],
      deskripsi: json['deskripsi'],
    );
  }
}
