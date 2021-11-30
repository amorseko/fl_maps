import 'package:json_annotation/json_annotation.dart';

part 'member_model.g.dart';

@JsonSerializable()
class MemberModels {
  int code;
  String message;
  bool status;
  _Data data;

//  List<_Data> data = [];

  MemberModels({this.code, this.message, this.status, this.data});

  factory MemberModels.fromJson(Map<String, dynamic> json) =>
      _$MemberModelsFromJson(json);

  Map<String, dynamic> toJson() => _$MemberModelsToJson(this);

  MemberModels.withError(String error)
      : message = error,
        status = false;
}

@JsonSerializable()
class _Data {
  _Data(
      {this.username,
        this.level,
        this.id,
        this.name,
        this.is_active,
        this.pict,
        this.images,
        this.no_hp,
        this.no_telp,
        this.id_provinsi,
        this.id_kota,
        this.id_gapoktan,
        this.lat,
        this.long
      });

  @JsonKey(name: 'username')
  String username;
  @JsonKey(name: 'level')
  String level;
  @JsonKey(name: 'id')
  String id;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'is_active')
  String is_active;
  @JsonKey(name: 'pict')
  String pict;
  @JsonKey(name: 'images')
  String images;
  @JsonKey(name: 'no_hp')
  String no_hp;
  @JsonKey(name: 'no_telp')
  String no_telp;
  @JsonKey(name: 'id_provinsi')
  String id_provinsi;
  @JsonKey(name: 'id_kota')
  String id_kota;
  @JsonKey(name: 'id_gapoktan')
  String id_gapoktan;
  @JsonKey(name: 'lat')
  String lat;
  @JsonKey(name: 'long')
  String long;

  factory _Data.fromJson(Map<String, dynamic> json) => _$_DataFromJson(json);

  Map<String, dynamic> toJson() => _$_DataToJson(this);
}