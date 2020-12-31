// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aboutus_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AboutsModels _$AboutsModelsFromJson(Map<String, dynamic> json) {
  return AboutsModels(
      message: json['message'] as String,
      status: json['status'] as String,
      data: (json['data'] as List)
          ?.map((e) =>
              e == null ? null : Data.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      error: json['error'] as bool);
}

Map<String, dynamic> _$AboutsModelsToJson(AboutsModels instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'error': instance.error,
      'data': instance.data
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(info: json['info'] as String);
}

Map<String, dynamic> _$DataToJson(Data instance) =>
    <String, dynamic>{'info': instance.info};
