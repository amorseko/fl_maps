class ReqListKinerjaOnly {
  final String id;
  final String id_provinsi;
  final String id_kota;
  final String id_gapoktan;

  ReqListKinerjaOnly({this.id, this.id_provinsi, this.id_kota, this.id_gapoktan});

  factory ReqListKinerjaOnly.fromJson(Map<String, dynamic> json) {
    return ReqListKinerjaOnly(
      id: json['id'],
      id_provinsi: json['id_provinsi'],
      id_kota: json['id_kota'],
      id_gapoktan: json['id_gapoktan'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["id_provinsi"] = id_provinsi;
    map["id_kota"] = id_kota;
    map["id_gapoktan"] = id_gapoktan;
    return map;
  }

}