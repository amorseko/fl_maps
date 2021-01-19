import 'package:json_annotation/json_annotation.dart';

part 'model_list_notif.g.dart';
@JsonSerializable(nullable: true)
class GetListNotifModels {
  String status;
  bool error;
  String message;

  List<GetListdataNotif> data = [];

  GetListNotifModels(
      {this.status,this.error, this.message, this.data});

  factory GetListNotifModels.fromJson(Map<String, dynamic> json) =>
      _$GetListNotifModelsFromJson(json);


  Map<String, dynamic> toJson() => _$GetListNotifModelsToJson(this);
}

@JsonSerializable()
class GetListdataNotif {
  GetListdataNotif(
      {
        this.id,
        this.id_user,
        this.token,
        this.message,
        this.type,
        this.title,
        this.date_time,
      }
      );

  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'id_user')
  String id_user;

  @JsonKey(name: 'token')
  String token;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'type')
  String type;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'date_time')
  String date_time;

  factory GetListdataNotif.fromJson(Map<String, dynamic> json) => _$GetListdataNotifFromJson(json);

  Map<String, dynamic> toJson() => _$GetListdataNotifToJson(this);
}
