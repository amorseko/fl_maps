import 'package:json_annotation/json_annotation.dart';

part 'model_jenis_bantuan_flag.g.dart';

@JsonSerializable()
class GetListJenisBantuanFlagModel {
  String message;
  String status;
  bool error;
  List<_Data> data;

  GetListJenisBantuanFlagModel({this.message, this.status, this.data, this.error});

  factory GetListJenisBantuanFlagModel.fromJson(Map<String, dynamic> json) =>
      _$GetListJenisBantuanFlagModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetListJenisBantuanFlagModelToJson(this);

  GetListJenisBantuanFlagModel.withError(String error)
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
