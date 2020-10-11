import 'package:json_annotation/json_annotation.dart';

part 'model_provinsi.g.dart';

@JsonSerializable()
class GetListModelProvinsi {
  String message;
  String status;
  bool error;
  List<_Data> data;

  GetListModelProvinsi({this.message, this.status, this.data, this.error});

  factory GetListModelProvinsi.fromJson(Map<String, dynamic> json) =>
      _$GetListModelProvinsiFromJson(json);

  Map<String, dynamic> toJson() => _$GetListModelProvinsiToJson(this);

  GetListModelProvinsi.withError(String error)
      : message = error,
        error = false;
}

@JsonSerializable()
class _Data {
  _Data({this.id_prov, this.nama});

  @JsonKey(name: 'id_prov')
  String id_prov;

  @JsonKey(name: 'nama')
  String nama;

  factory _Data.fromJson(Map<String, dynamic> json) => _$_DataFromJson(json);

  Map<String, dynamic> toJson() => _$_DataToJson(this);
}
