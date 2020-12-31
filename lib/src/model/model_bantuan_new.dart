import 'package:json_annotation/json_annotation.dart';

part 'model_bantuan_new.g.dart';

@JsonSerializable(nullable: true)
class GetModelBantuanNew {
  String status;
  bool error;
  String message;

  List<GetListdataBantuanNew> data = [];

  GetModelBantuanNew(
      {this.status,this.error, this.message, this.data});

  factory GetModelBantuanNew.fromJson(Map<String, dynamic> json) =>
      _$GetModelBantuanNewFromJson(json);


  Map<String, dynamic> toJson() => _$GetModelBantuanNewToJson(this);


}

@JsonSerializable(nullable: true)
class GetListdataBantuanNew {

  GetListdataBantuanNew(
      {
        this.id_bantuan,
        this.user_input,
        this.nama_kegiatan,
        this.nama_gapoktan,
        this.nomor_spk,
        this.tahap_bantuan,
      }
      );

  @JsonKey(name: 'id_bantuan')
  String id_bantuan;

  @JsonKey(name: 'user_input')
  String user_input;

  @JsonKey(name: 'nama_kegiatan')
  String nama_kegiatan;

  @JsonKey(name: 'nama_gapoktan')
  String nama_gapoktan;

  @JsonKey(name: 'nomor_spk')
  String nomor_spk;

  @JsonKey(name: 'tahun')
  String tahun;

  @JsonKey(name: 'tahap_bantuan')
  String tahap_bantuan;


  factory GetListdataBantuanNew.fromJson(Map<String, dynamic> json) => _$GetListdataBantuanNewFromJson(json);

  Map<String, dynamic> toJson() => _$GetListdataBantuanNewToJson(this);
}

