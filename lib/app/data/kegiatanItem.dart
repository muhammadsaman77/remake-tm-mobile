class Kegiatan {
  final int id;
  final String? namaKegiatan;
  final String detail;
  final DateTime waktuKegiatan;
  final DateTime? waktuSelesai;

  Kegiatan({
    required this.id,
    this.namaKegiatan,
    required this.detail,
    required this.waktuKegiatan,
    this.waktuSelesai,
  });

  // Factory method untuk membuat objek dari JSON
  factory Kegiatan.fromJson(Map<String, dynamic> json) {
    return Kegiatan(
      id: json['id'],
      namaKegiatan: json['nama_kegiatan'],
      detail: json['detail'],
      waktuKegiatan: DateTime.parse(json['waktu_kegiatan']),
      waktuSelesai: json['waktu_selesai'] != null
          ? DateTime.parse(json['waktu_selesai'])
          : null,
    );
  }

  // Method untuk mengubah objek menjadi JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama_kegiatan': namaKegiatan,
      'detail': detail,
      'waktu_kegiatan': waktuKegiatan.toIso8601String(),
      'waktu_selesai': waktuSelesai?.toIso8601String(),
    };
  }
}
