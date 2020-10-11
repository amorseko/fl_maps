// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_master_komoditi.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetListModelMasterKomoditi _$GetListModelMasterKomoditiFromJson(
    Map<String, dynamic> json) {
  return GetListModelMasterKomoditi(
      message: json['message'] as String,
      status: json['status'] as String,
      data: (json['data'] as List)
          ?.map((e) =>
              e == null ? null : _Data.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      error: json['error'] as bool);
}

Map<String, dynamic> _$GetListModelMasterKomoditiToJson(
        GetListModelMasterKomoditi instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'error': instance.error,
      'data': instance.data
    };

_Data _$_DataFromJson(Map<String, dynamic> json) {
  return _Data(id: json['id'] as String, name: json['name'] as String);
}

Map<String, dynamic> _$_DataToJson(_Data instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};
