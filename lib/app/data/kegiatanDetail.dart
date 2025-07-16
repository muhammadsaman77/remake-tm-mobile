class KegiatanDetail {
  int id;
  String namaKegiatan;
  String detail;
  DateTime waktuKegiatan;
  DateTime? waktuSelesai;
  String daftarRekan;
  String rutePatroli;
  String dokumentasi;
  String kesatuan;
  String namaPersonil;
  String jenisKegiatan;

  KegiatanDetail({
    required this.id,
    required this.namaKegiatan,
    required this.detail,
    required this.waktuKegiatan,
    this.waktuSelesai,
    required this.daftarRekan,
    required this.rutePatroli,
    required this.dokumentasi,
    required this.kesatuan,
    required this.namaPersonil,
    required this.jenisKegiatan,
  });

  // Factory method untuk membuat objek dari JSON
  factory KegiatanDetail.fromJson(Map<String, dynamic> json) {
    return KegiatanDetail(
      id: json['id'],
      namaKegiatan: json['nama_kegiatan'] ?? "",
      detail: json['detail'] ?? "",
      waktuKegiatan: DateTime.parse(json['waktu_kegiatan']),
      waktuSelesai: json['waktu_selesai'] != null
          ? DateTime.parse(json['waktu_selesai'])
          : null,
      daftarRekan: json['daftar_rekan'] ?? "",
      rutePatroli: json['rute_patroli'] ?? "",
      dokumentasi: json['dokumentasi'] ?? "",
      kesatuan: json['kesatuan'] ?? "",
      namaPersonil: json['nama_personil'] ?? "",
      jenisKegiatan: json['jenis_kegiatan'] ?? "",
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
      'daftar_rekan': daftarRekan,
      'rute_patroli': rutePatroli,
      'dokumentasi': dokumentasi,
      'kesatuan': kesatuan,
      'nama_personil': namaPersonil,
      'jenis_kegiatan': jenisKegiatan,
    };
  }
}
