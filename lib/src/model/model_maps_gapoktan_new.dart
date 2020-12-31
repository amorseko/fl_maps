import 'package:json_annotation/json_annotation.dart';

part 'model_maps_gapoktan_new.g.dart';

@JsonSerializable(nullable: true)
class GetMapsGapoktanModels {
  String status;
  bool error;
  String message;

  List<ListMapsDataGapoktan> data = [];

  GetMapsGapoktanModels(
      {this.status,this.error, this.message, this.data});

  factory GetMapsGapoktanModels.fromJson(Map<String, dynamic> json) =>
      _$GetMapsGapoktanModelsFromJson(json);


  Map<String, dynamic> toJson() => _$GetMapsGapoktanModelsToJson(this);


}

@JsonSerializable(nullable: true)
class ListMapsDataGapoktan {

  ListMapsDataGapoktan(
      {
        this.lat,
        this.long,
        this.gapoktan,
        this.nama_produk,
        this.jenis_produk,
        this.alamat,
        this.nama_pic,
        this.no_pic,
        this.no_telp,
        this.nama_kota,
        this.nama_provinsi,
        this.icon,
        this.icon_default,
        this.nama_komoditi,
      }
      );

  @JsonKey(name: 'lat')
  String lat;
  @JsonKey(name: 'long')
  String long;
  @JsonKey(name: 'gapoktan')
  String gapoktan;
  @JsonKey(name: 'nama_produk')
  String nama_produk;
  @JsonKey(name: 'alamat')
  String alamat;
  @JsonKey(name: 'nama_pic')
  String nama_pic;
  @JsonKey(name: 'no_pic')
  String no_pic;
  @JsonKey(name: 'no_telp')
  String no_telp;
  @JsonKey(name: 'nama_kota')
  String nama_kota;
  @JsonKey(name: 'nama_provinsi')
  String nama_provinsi;
  @JsonKey(name: 'icon')
  String icon;
  @JsonKey(name: 'jenis_produk')
  String jenis_produk;
  @JsonKey(name: 'icon_default')
  String icon_default;
  @JsonKey(name: 'nama_komoditi')
  String nama_komoditi;


  factory ListMapsDataGapoktan.fromJson(Map<String, dynamic> json) => _$ListMapsDataGapoktanFromJson(json);

  Map<String, dynamic> toJson() => _$ListMapsDataGapoktanToJson(this);
}

