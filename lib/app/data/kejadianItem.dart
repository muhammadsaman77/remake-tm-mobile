class Kejadian {
  final int id;
  final String kejadian;
  final String lokasi;
  final String keterangan;
  final DateTime? waktuKejadian;
  final DateTime? updatedAt;
  final String status;

  Kejadian(
      {required this.id,
      required this.kejadian,
      required this.lokasi,
      required this.keterangan,
      this.waktuKejadian,
      this.updatedAt,
      required this.status});

  // Factory method untuk membuat objek dari JSON
  factory Kejadian.fromJson(Map<String, dynamic> json) {
    return Kejadian(
      id: json['id'],
      kejadian: json['kejadian'] ?? "-",
      lokasi: json['lokasi'] ?? "-",
      keterangan: json['keterangan'] ?? "-",
      waktuKejadian: json['w_kejadian'] != null
          ? DateTime.parse(json['w_kejadian'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      status: json['status'] ?? "-",
    );
  }

  // Method untuk mengubah objek menjadi JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'kejadian': kejadian,
      'lokasi': lokasi,
      'keterangan': keterangan,
      'waktu_kejadian': waktuKejadian?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'status': status,
    };
  }
}
