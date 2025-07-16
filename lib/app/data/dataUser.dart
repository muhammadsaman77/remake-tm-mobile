class UserData {
  final String nrp;
  final String nama;
  final String? photo;
  final String kesatuan;
  final String statusDinasId;
  final String statusDinasKegiatan;
  final DateTime? absensiWaktuDatang;
  final DateTime? absensiWaktuPulang;

  UserData({
    required this.nrp,
    required this.nama,
    this.photo,
    required this.kesatuan,
    required this.statusDinasId,
    required this.statusDinasKegiatan,
    this.absensiWaktuDatang,
    this.absensiWaktuPulang,
  });

  // Factory method untuk membuat objek dari JSON
  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      nrp: json['nrp'],
      nama: json['nama'],
      photo: json['photo'],
      kesatuan: json['kesatuan'],
      statusDinasId: json['status_dinas_id'],
      statusDinasKegiatan: json['status_dinas_kegiatan'],
      absensiWaktuDatang: json['absensi_waktu_datang'] != null
          ? DateTime.parse(json['absensi_waktu_datang'])
          : null,
      absensiWaktuPulang: json['absensi_waktu_pulang'] != null
          ? DateTime.parse(json['absensi_waktu_pulang'])
          : null,
    );
  }

  // Method untuk mengubah objek menjadi JSON
  Map<String, dynamic> toJson() {
    return {
      'nrp': nrp,
      'nama': nama,
      'photo': photo,
      'kesatuan': kesatuan,
      'status_dinas_id': statusDinasId,
      'status_dinas_kegiatan': statusDinasKegiatan,
      'absensi_waktu_datang':
          absensiWaktuDatang?.toIso8601String(), // Format ISO 8601
      'absensi_waktu_pulang':
          absensiWaktuPulang?.toIso8601String(), // Format ISO 8601
    };
  }
}
