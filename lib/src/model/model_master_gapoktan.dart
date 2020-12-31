import 'package:json_annotation/json_annotation.dart';

part 'model_master_gapoktan.g.dart';

@JsonSerializable()
class GetListMasterGapoktanData {
  String message;
  String status;
  bool error;
  List<ListMasterGapoktan> data = [];


  GetListMasterGapoktanData({this.message, this.status, this.data, this.error});

  factory GetListMasterGapoktanData.fromJson(Map<String, dynamic> json) =>
      _$GetListMasterGapoktanDataFromJson(json);

  Map<String, dynamic> toJson() => _$GetListMasterGapoktanDataToJson(this);

  GetListMasterGapoktanData.withError(String error)
      : message = error,
        error = false;
}

@JsonSerializable()
class ListMasterGapoktan{
  ListMasterGapoktan({this.id_gapoktan, this.nama_gapoktan});

  @JsonKey(name: 'id_gapoktan')
  String id_gapoktan;

  @JsonKey(name: 'nama_gapoktan')
  String nama_gapoktan;

  factory ListMasterGapoktan.fromJson(Map<String, dynamic> json) => _$ListMasterGapoktanFromJson(json);

  Map<String, dynamic> toJson() => _$ListMasterGapoktanToJson(this);
}
