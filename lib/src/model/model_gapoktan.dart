import 'package:json_annotation/json_annotation.dart';

part 'model_gapoktan.g.dart';

@JsonSerializable(nullable: true)
class GetModelGapoktan {
  String status;
  bool error;
  String message;

  List<ListGapoktanData> data = [];

  GetModelGapoktan(
      {this.status,this.error, this.message, this.data});

  factory GetModelGapoktan.fromJson(Map<String, dynamic> json) =>
      _$GetModelGapoktanFromJson(json);


  Map<String, dynamic> toJson() => _$GetModelGapoktanToJson(this);


}

@JsonSerializable(nullable: true)
class ListGapoktanData {

  ListGapoktanData(
      {
        this.gapoktan,
        this.id_gapoktan,
        this.nama_provinsi,
        this.nama_komoditi,
        this.nama_produk,
      }
      );

  @JsonKey(name: 'id_gapoktan')
  String id_gapoktan;

  @JsonKey(name: 'gapoktan')
  String gapoktan;

  @JsonKey(name: 'nama_provinsi')
  String nama_provinsi;

  @JsonKey(name: 'nama_komoditi')
  String nama_komoditi;

  @JsonKey(name: 'nama_produk')
  String nama_produk;


  factory ListGapoktanData.fromJson(Map<String, dynamic> json) => _$ListGapoktanDataFromJson(json);

  Map<String, dynamic> toJson() => _$ListGapoktanDataToJson(this);
}

