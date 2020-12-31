import 'package:json_annotation/json_annotation.dart';

part 'model_list_kota.g.dart';
@JsonSerializable()
class GetListKotaModels {
  String message;
  String status;
  bool error;
  List<_Data> data;

  GetListKotaModels({this.message, this.status, this.data, this.error});

  factory GetListKotaModels.fromJson(Map<String, dynamic> json) =>
      _$GetListKotaModelsFromJson(json);

  Map<String, dynamic> toJson() => _$GetListKotaModelsToJson(this);

  GetListKotaModels.withError(String error)
      : message = error,
        error = false;
}

@JsonSerializable()
class _Data {
  _Data(
      {this.id_kota,
        this.nama_kota
      }
      );

  @JsonKey(name: 'id_kota')
  String id_kota;

  @JsonKey(name: 'nama_kota')
  String nama_kota;

  @JsonKey(name: 'satuan')
  String satuan;

  factory _Data.fromJson(Map<String, dynamic> json) => _$_DataFromJson(json);

  Map<String, dynamic> toJson() => _$_DataToJson(this);
}
