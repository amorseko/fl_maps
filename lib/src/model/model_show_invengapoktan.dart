import 'package:json_annotation/json_annotation.dart';

part 'model_show_invengapoktan.g.dart';

@JsonSerializable(nullable: true)
class GetModelListInvenGapoktan {
  String status;
  bool error;
  String message;

  List<ListInvenGapoktan> data = [];

  GetModelListInvenGapoktan(
      {this.status,this.error, this.message, this.data});

  factory GetModelListInvenGapoktan.fromJson(Map<String, dynamic> json) =>
      _$GetModelListInvenGapoktanFromJson(json);


  Map<String, dynamic> toJson() => _$GetModelListInvenGapoktanToJson(this);


}

@JsonSerializable(nullable: true)
class ListInvenGapoktan {

  ListInvenGapoktan(
      {
        this.id_inventaris,
        this.nama_gapoktan,
        this.nama_bantuan,
        this.spesifikasi,
        this.tahun,
        this.asal_dana,
      }
      );

  @JsonKey(name: 'id_inventaris')
  String id_inventaris;

  @JsonKey(name: 'nama_gapoktan')
  String nama_gapoktan;

  @JsonKey(name: 'nama_bantuan')
  String nama_bantuan;

  @JsonKey(name: 'spesifikasi')
  String spesifikasi;

  @JsonKey(name: 'tahun')
  String tahun;

  @JsonKey(name: 'asal_dana')
  String asal_dana;


  factory ListInvenGapoktan.fromJson(Map<String, dynamic> json) => _$ListInvenGapoktanFromJson(json);

  Map<String, dynamic> toJson() => _$ListInvenGapoktanToJson(this);
}

