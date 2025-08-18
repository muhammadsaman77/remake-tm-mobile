class Personil {
  final int id;
  final String nama;
  final String sessionName;



  Personil({
    required this.id,
    required this.nama,
    required this.sessionName


  });

  // Factory method untuk membuat objek dari JSON
  factory Personil.fromJson(Map<String, dynamic> json) {
    return Personil(
      id: json['id'],
      nama: json['kesatuan'],
      sessionName: json['kode_satuan']

    );
  }

  // Method untuk mengubah objek menjadi JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,

    };
  }
}
