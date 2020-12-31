import 'package:json_annotation/json_annotation.dart';

part 'aboutus_model.g.dart';

@JsonSerializable(nullable: true)
class AboutsModels {
  String message;
  String status;
  bool error;
  List<Data> data = [];

  AboutsModels({this.message, this.status, this.data, this.error});

  factory AboutsModels.fromJson(Map<String, dynamic> json) =>
      _$AboutsModelsFromJson(json);

  Map<String, dynamic> toJson() => _$AboutsModelsToJson(this);

  AboutsModels.withError(String error)
      : message = error,
        error = true;
}

@JsonSerializable(nullable: true)
class Data {
  Data({this.info});

  @JsonKey(name: 'info')
  String info;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

