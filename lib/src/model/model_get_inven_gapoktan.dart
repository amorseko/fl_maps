import 'package:json_annotation/json_annotation.dart';

part 'model_get_inven_gapoktan.g.dart';

@JsonSerializable(nullable: true)
class GetModelInvenGapoktan {
  String status;
  bool error;
  String message;

  List<GetListdatInvenGapoktan> data = [];

  GetModelInvenGapoktan(
      {this.status,this.error, this.message, this.data});

  factory GetModelInvenGapoktan.fromJson(Map<String, dynamic> json) =>
      _$GetModelInvenGapoktanFromJson(json);


  Map<String, dynamic> toJson() => _$GetModelInvenGapoktanToJson(this);


}

@JsonSerializable(nullable: true)
class GetListdatInvenGapoktan {

  GetListdatInvenGapoktan(
      {
        this.id_inventaris,
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
        this.file_penunjang,
        this.is_bantuan,
        this.pemanfaatan,
      }
      );

  @JsonKey(name: 'id_inventaris')
  String id_inventaris;

  @JsonKey(name: 'id_gapoktan')
  String id_gapoktan;

  @JsonKey(name: 'id_jenis_bantuan')
  String id_jenis_bantuan;

  @JsonKey(name: 'spesifikasi')
  String spesifikasi;

  @JsonKey(name: 'tahun')
  String tahun;

  @JsonKey(name: 'tahun_pembuatan')
  String tahun_pembuatan;

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

  @JsonKey(name: 'id_bantuan')
  String id_bantuan;

  @JsonKey(name: 'file_penunjang')
  String file_penunjang;

  @JsonKey(name: 'is_bantuan')
  String is_bantuan;

  @JsonKey(name: 'pemanfaatan')
  String pemanfaatan;



  factory GetListdatInvenGapoktan.fromJson(Map<String, dynamic> json) => _$GetListdatInvenGapoktanFromJson(json);

  Map<String, dynamic> toJson() => _$GetListdatInvenGapoktanToJson(this);
}

