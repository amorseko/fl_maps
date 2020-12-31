import 'package:json_annotation/json_annotation.dart';

part 'model_total_data.g.dart';

@JsonSerializable()
class GetListModelTotalData {
  String message;
  String status;
  bool error;
  List<_Data> data;

  GetListModelTotalData({this.message, this.status, this.data, this.error});

  factory GetListModelTotalData.fromJson(Map<String, dynamic> json) =>
      _$GetListModelTotalDataFromJson(json);

  Map<String, dynamic> toJson() => _$GetListModelTotalDataToJson(this);

  GetListModelTotalData.withError(String error)
      : message = error,
        error = false;
}

@JsonSerializable()
class _Data {
  _Data({this.total_gapoktan, this.total_bantuan, this.total_kinerja});

  @JsonKey(name: 'total_gapoktan')
  String total_gapoktan;

  @JsonKey(name: 'total_bantuan')
  String total_bantuan;

  @JsonKey(name: 'total_kinerja')
  String total_kinerja;

  factory _Data.fromJson(Map<String, dynamic> json) => _$_DataFromJson(json);

  Map<String, dynamic> toJson() => _$_DataToJson(this);
}
