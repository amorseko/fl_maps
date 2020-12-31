import 'package:json_annotation/json_annotation.dart';

part 'model_maps.g.dart';

@JsonSerializable(nullable: true)
class GetMapsPartModels {
  String status;
  bool error;
  String message;

  List<ListMapsData> data = [];

  GetMapsPartModels(
      {this.status,this.error, this.message, this.data});

  factory GetMapsPartModels.fromJson(Map<String, dynamic> json) =>
      _$GetMapsPartModelsFromJson(json);


  Map<String, dynamic> toJson() => _$GetMapsPartModelsToJson(this);


}

@JsonSerializable(nullable: true)
class ListMapsData {

  ListMapsData(
      {
        this.lat,
        this.long,
        this.gapoktan,
        this.nama_kegiatan,
        this.nomor_spk,
        this.nama_produk,
        this.alamat,
        this.nama_pic,
        this.no_pic,
        this.no_telp,
        this.nama_kota,
        this.nama_provinsi,
        this.icon_bantuan,
        this.nama_komoditi,
      }
      );

  @JsonKey(name: 'lat')
  String lat;
  @JsonKey(name: 'long')
  String long;
  @JsonKey(name: 'gapoktan')
  String gapoktan;
  @JsonKey(name: 'nama_kegiatan')
  String nama_kegiatan;
  @JsonKey(name: 'nomor_spk')
  String nomor_spk;
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
  @JsonKey(name: 'icon_bantuan')
  String icon_bantuan;
  @JsonKey(name: 'nama_komoditi')
  String nama_komoditi;


  factory ListMapsData.fromJson(Map<String, dynamic> json) => _$ListMapsDataFromJson(json);

  Map<String, dynamic> toJson() => _$ListMapsDataToJson(this);
}

