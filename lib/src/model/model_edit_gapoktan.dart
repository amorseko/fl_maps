import 'package:json_annotation/json_annotation.dart';

part 'model_edit_gapoktan.g.dart';

@JsonSerializable(nullable: true)
class GetModelEditGapoktan {
  String status;
  bool error;
  String message;

  List<ListGapoktanDataEdit> data = [];

  GetModelEditGapoktan(
      {this.status,this.error, this.message, this.data});

  factory GetModelEditGapoktan.fromJson(Map<String, dynamic> json) =>
      _$GetModelEditGapoktanFromJson(json);


  Map<String, dynamic> toJson() => _$GetModelEditGapoktanToJson(this);


}

@JsonSerializable(nullable: true)
class ListGapoktanDataEdit {

  ListGapoktanDataEdit(
      {
        this.id_gapoktan,
        this.id_provinsi,
        this.id_komoditi,
        this.id_kota,
        this.nama_produk,
        this.nama_gapoktan,
        this.alamat,
        this.nama_pic,
        this.no_pic,
        this.jenis_produk,
        this.kapasitas,
        this.pasar,
        this.kemitraan,
      }
      );

  @JsonKey(name: 'id_gapoktan')
  String id_gapoktan;

  @JsonKey(name: 'id_provinsi')
  String id_provinsi;

  @JsonKey(name: 'id_komoditi')
  String id_komoditi;

  @JsonKey(name: 'id_kota')
  String id_kota;

  @JsonKey(name: 'nama_produk')
  String nama_produk;

  @JsonKey(name: 'nama_gapoktan')
  String nama_gapoktan;

  @JsonKey(name: 'alamat')
  String alamat;

  @JsonKey(name: 'nama_pic')
  String nama_pic;

  @JsonKey(name: 'no_pic')
  String no_pic;

  @JsonKey(name: 'jenis_produk')
  String jenis_produk;

  @JsonKey(name: 'kapasitas')
  String kapasitas;

  @JsonKey(name: 'pasar')
  String pasar;

  @JsonKey(name: 'kemitraan')
  String kemitraan;


  factory ListGapoktanDataEdit.fromJson(Map<String, dynamic> json) => _$ListGapoktanDataEditFromJson(json);

  Map<String, dynamic> toJson() => _$ListGapoktanDataEditToJson(this);
}

