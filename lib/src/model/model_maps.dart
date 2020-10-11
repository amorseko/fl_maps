import 'package:json_annotation/json_annotation.dart';

part 'model_maps.g.dart';

@JsonSerializable(nullable: true)
class GetMapsPartModels {
  String status;
  bool error;
  String message;

  List<ListMapsData> data = [];

  GetMapsPartModels(
      {this.status,this.error, this.message, this.data});

  factory GetMapsPartModels.fromJson(Map<String, dynamic> json) =>
      _$GetMapsPartModelsFromJson(json);


  Map<String, dynamic> toJson() => _$GetMapsPartModelsToJson(this);


}

@JsonSerializable(nullable: true)
class ListMapsData {

  ListMapsData(
      {
        this.lat,
        this.long,
        this.gapoktan,
      }
      );

  @JsonKey(name: 'lat')
  String lat;
  @JsonKey(name: 'long')
  String long;
  @JsonKey(name: 'gapoktan')
  String gapoktan;


  factory ListMapsData.fromJson(Map<String, dynamic> json) => _$ListMapsDataFromJson(json);

  Map<String, dynamic> toJson() => _$ListMapsDataToJson(this);
}

