import 'package:json_annotation/json_annotation.dart';

part 'model_master_jenis_bantuan.g.dart';

@JsonSerializable()
class GetListMasterJenisBantuan {
  String message;
  String status;
  bool error;
  List<ListMasterJenisBantuan> data = [];


  GetListMasterJenisBantuan({this.message, this.status, this.data, this.error});

  factory GetListMasterJenisBantuan.fromJson(Map<String, dynamic> json) =>
      _$GetListMasterJenisBantuanFromJson(json);

  Map<String, dynamic> toJson() => _$GetListMasterJenisBantuanToJson(this);

  GetListMasterJenisBantuan.withError(String error)
      : message = error,
        error = false;
}

@JsonSerializable()
class ListMasterJenisBantuan{
  ListMasterJenisBantuan({this.id, this.name});

  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'name')
  String name;

  factory ListMasterJenisBantuan.fromJson(Map<String, dynamic> json) => _$ListMasterJenisBantuanFromJson(json);

  Map<String, dynamic> toJson() => _$ListMasterJenisBantuanToJson(this);
}
