import 'package:json_annotation/json_annotation.dart';

part 'model_bantuan_detail.g.dart';

@JsonSerializable(nullable: true)
class GetModelBantuanDetail {
  String status;
  bool error;
  String message;

  List<GetListdataBantuanDetail> data = [];

  GetModelBantuanDetail(
      {this.status,this.error, this.message, this.data});

  factory GetModelBantuanDetail.fromJson(Map<String, dynamic> json) =>
      _$GetModelBantuanDetailFromJson(json);


  Map<String, dynamic> toJson() => _$GetModelBantuanDetailToJson(this);


}

@JsonSerializable(nullable: true)
class GetListdataBantuanDetail {

  GetListdataBantuanDetail(
      {
        this.id_bantuan,
        this.user_input,
        this.id_item_bantuan,
        this.name,
        this.kapasitas_terpasang,
        this.jumlah,
        this.spesifikasi,
        this.tahun_pembuatan,
      }
      );

  @JsonKey(name: 'id_bantuan')
  String id_bantuan;

  @JsonKey(name: 'user_input')
  String user_input;

  @JsonKey(name: 'id_item_bantuan')
  String id_item_bantuan;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'kapasitas_terpasang')
  String kapasitas_terpasang;

  @JsonKey(name: 'jumlah')
  String jumlah;

  @JsonKey(name: 'spesifikasi')
  String spesifikasi;

  @JsonKey(name: 'tahun_pembuatan')
  String tahun_pembuatan;


  factory GetListdataBantuanDetail.fromJson(Map<String, dynamic> json) => _$GetListdataBantuanDetailFromJson(json);

  Map<String, dynamic> toJson() => _$GetListdataBantuanDetailToJson(this);
}

