// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_total_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetListModelTotalData _$GetListModelTotalDataFromJson(
    Map<String, dynamic> json) {
  return GetListModelTotalData(
      message: json['message'] as String,
      status: json['status'] as String,
      data: (json['data'] as List)
          ?.map((e) =>
              e == null ? null : _Data.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      error: json['error'] as bool);
}

Map<String, dynamic> _$GetListModelTotalDataToJson(
        GetListModelTotalData instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'error': instance.error,
      'data': instance.data
    };

_Data _$_DataFromJson(Map<String, dynamic> json) {
  return _Data(
      total_gapoktan: json['total_gapoktan'] as String,
      total_bantuan: json['total_bantuan'] as String,
      total_kinerja: json['total_kinerja'] as String);
}

Map<String, dynamic> _$_DataToJson(_Data instance) => <String, dynamic>{
      'total_gapoktan': instance.total_gapoktan,
      'total_bantuan': instance.total_bantuan,
      'total_kinerja': instance.total_kinerja
    };
