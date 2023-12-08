class CardPerizinan {
  final String title;
  final String requirements;
  final String processingTime;
  final void Function()? onTap; // Properti fungsi onTap
  final String bannerimage;

  CardPerizinan({
    required this.title,
    required this.requirements,
    required this.processingTime,
    this.onTap, // Inisialisasi onTap
    required this.bannerimage,
  });
}

class TKCardPerizinan extends CardPerizinan {
  TKCardPerizinan({
    required String title,
    required String requirements,
    required String processingTime,
    void Function()? onTap, // Properti fungsi onTap
    required String bannerimage,
  }) : super(
            title: title,
            requirements: requirements,
            processingTime: processingTime,
            onTap: onTap, // Inisialisasi onTap
            bannerimage: bannerimage);
}

class JenisSurat {
  final int id;
  final String nama;
  final String? deskripsi;
  final String? gambarAlurPermohonan;
  final String? gambarServiceLevelAggreement;

  JenisSurat({
    required this.id,
    required this.nama,
    this.deskripsi,
    this.gambarAlurPermohonan,
    this.gambarServiceLevelAggreement,
  });

  factory JenisSurat.fromJson(Map<String, dynamic> json) {
    return JenisSurat(
      id: json['id'],
      nama: json['nama'],
      deskripsi: json['deskripsi'],
      gambarAlurPermohonan: json['gambar_alur_permohonan'],
      gambarServiceLevelAggreement: json['gambar_service_level_aggreement'],
    );
  }
}
