// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_get_komoditi.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetModelGetKomoditi _$GetModelGetKomoditiFromJson(Map<String, dynamic> json) {
  return GetModelGetKomoditi(
      status: json['status'] as String,
      error: json['error'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List)
          ?.map((e) => e == null
              ? null
              : ListDataKomoditi.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$GetModelGetKomoditiToJson(
        GetModelGetKomoditi instance) =>
    <String, dynamic>{
      'status': instance.status,
      'error': instance.error,
      'message': instance.message,
      'data': instance.data
    };

ListDataKomoditi _$ListDataKomoditiFromJson(Map<String, dynamic> json) {
  return ListDataKomoditi(
      id: json['id'] as String, name: json['name'] as String);
}

Map<String, dynamic> _$ListDataKomoditiToJson(ListDataKomoditi instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};
