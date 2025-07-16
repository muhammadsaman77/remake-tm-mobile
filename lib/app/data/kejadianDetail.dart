class KejadianDetail {
  int id;
  String kejadian;
  String lokasi;
  String keterangan;
  DateTime waktuKejadian;
  String dokumentasi;
  String status;
  DateTime? updatedAt;
  String kesatuan;
  String namaPersonil;

  KejadianDetail({
    required this.id,
    required this.kejadian,
    required this.lokasi,
    required this.keterangan,
    required this.waktuKejadian,
    required this.dokumentasi,
    required this.status,
    this.updatedAt,
    required this.kesatuan,
    required this.namaPersonil,
  });

  factory KejadianDetail.fromJson(Map<String, dynamic> json) {
    return KejadianDetail(
      id: json['id'],
      kejadian: json['kejadian'],
      lokasi: json['lokasi'],
      keterangan: json['keterangan'],
      waktuKejadian: DateTime.parse(json['w_kejadian']),
      dokumentasi: json['dokumentasi'],
      status: json['status'],
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      kesatuan: json['kesatuan'],
      namaPersonil: json['nama_personil'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'kejadian': kejadian,
      'lokasi': lokasi,
      'keterangan': keterangan,
      'w_kejadian': waktuKejadian.toIso8601String(),
      'dokumentasi': dokumentasi,
      'status': status,
      'updated_at': updatedAt?.toIso8601String(),
      'kesatuan': kesatuan,
      'nama_personil': namaPersonil,
    };
  }
}
