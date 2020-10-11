import 'package:json_annotation/json_annotation.dart';

part 'model_list_komoditi.g.dart';

@JsonSerializable()
class GetListKomoditiData {
  String message;
  String status;
  bool error;
  List<ListKomoditiData> data = [];


  GetListKomoditiData({this.message, this.status, this.data, this.error});

  factory GetListKomoditiData.fromJson(Map<String, dynamic> json) =>
      _$GetListKomoditiDataFromJson(json);

  Map<String, dynamic> toJson() => _$GetListKomoditiDataToJson(this);

  GetListKomoditiData.withError(String error)
      : message = error,
        error = false;
}

@JsonSerializable()
class ListKomoditiData{
  ListKomoditiData({this.id, this.name});

  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'name')
  String name;

  factory ListKomoditiData.fromJson(Map<String, dynamic> json) => _$ListKomoditiDataFromJson(json);

  Map<String, dynamic> toJson() => _$ListKomoditiDataToJson(this);
}
