import 'package:json_annotation/json_annotation.dart';

part 'model_get_bantuan.g.dart';

@JsonSerializable(nullable: true)
class GetModelBantuan {
  String status;
  bool error;
  String message;

  List<GetListdataBantuan> data = [];

  GetModelBantuan(
      {this.status,this.error, this.message, this.data});

  factory GetModelBantuan.fromJson(Map<String, dynamic> json) =>
      _$GetModelBantuanFromJson(json);


  Map<String, dynamic> toJson() => _$GetModelBantuanToJson(this);


}

@JsonSerializable(nullable: true)
class GetListdataBantuan {

  GetListdataBantuan(
      {
        this.id_bantuan,
        this.id_gapoktan,
        this.id_jenis_bantuan,
        this.spesifikasi,
        this.tahun,
        this.jumlah,
        this.kapasitas,
        this.kondisi,
        this.asal_dana,
        this.tanggal_input,
        this.foto,
      }
      );

  @JsonKey(name: 'id_bantuan')
  String id_bantuan;

  @JsonKey(name: 'id_gapoktan')
  String id_gapoktan;

  @JsonKey(name: 'id_jenis_bantuan')
  String id_jenis_bantuan;

  @JsonKey(name: 'spesifikasi')
  String spesifikasi;

  @JsonKey(name: 'tahun')
  String tahun;

  @JsonKey(name: 'jumlah')
  String jumlah;

  @JsonKey(name: 'kapasitas')
  String kapasitas;

  @JsonKey(name: 'kondisi')
  String kondisi;

  @JsonKey(name: 'asal_dana')
  String asal_dana;

  @JsonKey(name: 'tanggal_input')
  String tanggal_input;

  @JsonKey(name: 'foto')
  String foto;


  factory GetListdataBantuan.fromJson(Map<String, dynamic> json) => _$GetListdataBantuanFromJson(json);

  Map<String, dynamic> toJson() => _$GetListdataBantuanToJson(this);
}

