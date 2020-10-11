// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_list_komoditi.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetListKomoditiData _$GetListKomoditiDataFromJson(Map<String, dynamic> json) {
  return GetListKomoditiData(
      message: json['message'] as String,
      status: json['status'] as String,
      data: (json['data'] as List)
          ?.map((e) => e == null
              ? null
              : ListKomoditiData.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      error: json['error'] as bool);
}

Map<String, dynamic> _$GetListKomoditiDataToJson(
        GetListKomoditiData instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'error': instance.error,
      'data': instance.data
    };

ListKomoditiData _$ListKomoditiDataFromJson(Map<String, dynamic> json) {
  return ListKomoditiData(
      id: json['id'] as String, name: json['name'] as String);
}

Map<String, dynamic> _$ListKomoditiDataToJson(ListKomoditiData instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};
