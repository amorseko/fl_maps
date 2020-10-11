import 'package:json_annotation/json_annotation.dart';

part 'model_master_komoditi.g.dart';

@JsonSerializable()
class GetListModelMasterKomoditi {
  String message;
  String status;
  bool error;
  List<_Data> data;


  GetListModelMasterKomoditi({this.message, this.status, this.data, this.error});

  factory GetListModelMasterKomoditi.fromJson(Map<String, dynamic> json) =>
      _$GetListModelMasterKomoditiFromJson(json);

  Map<String, dynamic> toJson() => _$GetListModelMasterKomoditiToJson(this);

  GetListModelMasterKomoditi.withError(String error)
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
