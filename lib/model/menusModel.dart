class Menus {
  String? nama;
  String? harga;
  String? gambar;
  String? tipe;

  Menus({this.nama, this.harga, this.gambar, this.tipe});

  factory Menus.fromMap(Map<String, dynamic> map) {
    return Menus(
        gambar: map['gambar'],
        harga: map['harga'],
        nama: map['nama'],
        tipe: map['tipe']);
  }
}
