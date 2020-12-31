import 'package:json_annotation/json_annotation.dart';

part 'model_get_komoditi.g.dart';

@JsonSerializable(nullable: true)
class GetModelGetKomoditi {
  String status;
  bool error;
  String message;

  List<ListDataKomoditi> data = [];

  GetModelGetKomoditi(
      {this.status,this.error, this.message, this.data});

  factory GetModelGetKomoditi.fromJson(Map<String, dynamic> json) =>
      _$GetModelGetKomoditiFromJson(json);


  Map<String, dynamic> toJson() => _$GetModelGetKomoditiToJson(this);


}

@JsonSerializable(nullable: true)
class ListDataKomoditi {

  ListDataKomoditi(
      {
        this.id,
        this.name,
      }
      );

  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'name')
  String name;


  factory ListDataKomoditi.fromJson(Map<String, dynamic> json) => _$ListDataKomoditiFromJson(json);

  Map<String, dynamic> toJson() => _$ListDataKomoditiToJson(this);
}

