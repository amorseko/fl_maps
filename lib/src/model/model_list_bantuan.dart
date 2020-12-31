import 'package:json_annotation/json_annotation.dart';

part 'model_list_bantuan.g.dart';

@JsonSerializable(nullable: true)
class GetListBantuanModel {
  String message;
  String status;
  bool error;
  List<ListBantuanData> data = [];


  GetListBantuanModel({this.message, this.status, this.data, this.error});

  factory GetListBantuanModel.fromJson(Map<String, dynamic> json) =>
      _$GetListBantuanModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetListBantuanModelToJson(this);

  GetListBantuanModel.withError(String error)
      : message = error,
        error = false;
}

@JsonSerializable(nullable: true)
class ListBantuanData{
  ListBantuanData({this.id_bantuan, this.nama_gapoktan, this.nama_bantuan, this.spesifikasi,this.tahun, this.asal_dana});

  @JsonKey(name: 'id_bantuan')
  String id_bantuan;

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

  factory ListBantuanData.fromJson(Map<String, dynamic> json) => _$ListBantuanDataFromJson(json);

  Map<String, dynamic> toJson() => _$ListBantuanDataToJson(this);
}
