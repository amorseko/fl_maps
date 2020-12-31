import 'package:json_annotation/json_annotation.dart';

part 'model_jenis_proses.g.dart';

@JsonSerializable()
class GetListJenisProses {
  String message;
  String status;
  bool error;
  List<_Data> data;

  GetListJenisProses({this.message, this.status, this.data, this.error});

  factory GetListJenisProses.fromJson(Map<String, dynamic> json) =>
      _$GetListJenisProsesFromJson(json);

  Map<String, dynamic> toJson() => _$GetListJenisProsesToJson(this);

  GetListJenisProses.withError(String error)
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
