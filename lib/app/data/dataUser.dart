class Kesatuan {
  final int id;
  final String kesatuan;

  Kesatuan({
    required this.id,
    required this.kesatuan,
  });

  factory Kesatuan.fromJson(Map<String, dynamic> json) {
    return Kesatuan(
      id: json['id'],
      kesatuan: json['kesatuan'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'kesatuan': kesatuan,
    };
  }
}

class UserData {
  final String nrp;
  final String nama;
  final String? photo;
  final Kesatuan kesatuan;
  final String? statusDinasId;
  final String? statusDinasKegiatan;
  final DateTime? absensiWaktuDatang;
  final DateTime? absensiWaktuPulang;

  UserData({
    required this.nrp,
    required this.nama,
    this.photo,
    required this.kesatuan,
     this.statusDinasId,
    required this.statusDinasKegiatan,
    this.absensiWaktuDatang,
    this.absensiWaktuPulang,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      nrp: json['nrp'],
      nama: json['nama'],
      photo: json['photo'],
      kesatuan: Kesatuan.fromJson(json['kesatuan']),
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

  Map<String, dynamic> toJson() {
    return {
      'nrp': nrp,
      'nama': nama,
      'photo': photo,
      'kesatuan': kesatuan.toJson(),
      'status_dinas_id': statusDinasId,
      'status_dinas_kegiatan': statusDinasKegiatan,
      'absensi_waktu_datang': absensiWaktuDatang?.toIso8601String(),
      'absensi_waktu_pulang': absensiWaktuPulang?.toIso8601String(),
    };
  }
}
