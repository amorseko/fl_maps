class doReqGapoktan {
  final String id_gapoktan;
  final String komoditi;
  final String provinsi;
  final String nama_produk;
  final String nama_gapoktan;
  final String alamat;
  final String nama_pic;
  final String no_pic;
  final String jenis_produk;
  final String kapasitas;
  final String pasar;
  final String kemitraan;
  final String mode;
  final String id_kota;

  doReqGapoktan({this.id_gapoktan,this.komoditi, this.provinsi, this.nama_produk, this.nama_gapoktan, this.alamat, this.nama_pic, this.no_pic, this.jenis_produk, this.kapasitas, this.pasar, this.kemitraan, this.mode, this.id_kota});

  factory doReqGapoktan.fromJson(Map<String, dynamic> json) {
    return doReqGapoktan(
      id_gapoktan: json['id_gapoktan'],
      komoditi: json['komoditi'],
      provinsi: json['provinsi'],
      nama_produk: json['nama_produk'],
      nama_gapoktan: json['nama_gapoktan'],
      alamat: json['alamat'],
      nama_pic: json['nama_pic'],
      no_pic: json['no_pic'],
      jenis_produk: json['jenis_produk'],
      kapasitas: json['kapasitas'],
      pasar: json['pasar'],
      kemitraan: json['kemitraan'],
      mode: json['mode'],
      id_kota: json['id_kota'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id_gapoktan"] = id_gapoktan;
    map["komoditi"] = komoditi;
    map["provinsi"] = provinsi;
    map["nama_produk"] = nama_produk;
    map["nama_gapoktan"] = nama_gapoktan;
    map["alamat"] = alamat;
    map["nama_pic"] = nama_pic;
    map["no_pic"] = no_pic;
    map["jenis_produk"] = jenis_produk;
    map["kapasitas"] = kapasitas;
    map["pasar"] = pasar;
    map["kemitraan"] = kemitraan;
    map['mode'] = mode;
    map['id_kota'] = id_kota;
    return map;
  }

}