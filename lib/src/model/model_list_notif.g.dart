// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_list_notif.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetListNotifModels _$GetListNotifModelsFromJson(Map<String, dynamic> json) {
  return GetListNotifModels(
      status: json['status'] as String,
      error: json['error'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List)
          ?.map((e) => e == null
              ? null
              : GetListdataNotif.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$GetListNotifModelsToJson(GetListNotifModels instance) =>
    <String, dynamic>{
      'status': instance.status,
      'error': instance.error,
      'message': instance.message,
      'data': instance.data
    };

GetListdataNotif _$GetListdataNotifFromJson(Map<String, dynamic> json) {
  return GetListdataNotif(
      id: json['id'] as String,
      id_user: json['id_user'] as String,
      token: json['token'] as String,
      message: json['message'] as String,
      type: json['type'] as String,
      title: json['title'] as String,
      date_time: json['date_time'] as String);
}

Map<String, dynamic> _$GetListdataNotifToJson(GetListdataNotif instance) =>
    <String, dynamic>{
      'id': instance.id,
      'id_user': instance.id_user,
      'token': instance.token,
      'message': instance.message,
      'type': instance.type,
      'title': instance.title,
      'date_time': instance.date_time
    };
