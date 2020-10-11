import 'package:json_annotation/json_annotation.dart';

part 'model_jenis_bantuan.g.dart';

@JsonSerializable()
class GetListJenisBantuanModel {
  String message;
  String status;
  bool error;
  List<_Data> data;

  GetListJenisBantuanModel({this.message, this.status, this.data, this.error});

  factory GetListJenisBantuanModel.fromJson(Map<String, dynamic> json) =>
      _$GetListJenisBantuanModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetListJenisBantuanModelToJson(this);

  GetListJenisBantuanModel.withError(String error)
      : message = error,
        error = false;
}

@JsonSerializable()
class _Data {
  _Data({this.id, this.name});

  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'name')
  String name;

  factory _Data.fromJson(Map<String, dynamic> json) => _$_DataFromJson(json);

  Map<String, dynamic> toJson() => _$_DataToJson(this);
}
