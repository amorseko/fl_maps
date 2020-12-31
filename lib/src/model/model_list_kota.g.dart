// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_list_kota.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetListKotaModels _$GetListKotaModelsFromJson(Map<String, dynamic> json) {
  return GetListKotaModels(
      message: json['message'] as String,
      status: json['status'] as String,
      data: (json['data'] as List)
          ?.map((e) =>
              e == null ? null : _Data.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      error: json['error'] as bool);
}

Map<String, dynamic> _$GetListKotaModelsToJson(GetListKotaModels instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'error': instance.error,
      'data': instance.data
    };

_Data _$_DataFromJson(Map<String, dynamic> json) {
  return _Data(
      id_kota: json['id_kota'] as String,
      nama_kota: json['nama_kota'] as String)
    ..satuan = json['satuan'] as String;
}

Map<String, dynamic> _$_DataToJson(_Data instance) => <String, dynamic>{
      'id_kota': instance.id_kota,
      'nama_kota': instance.nama_kota,
      'satuan': instance.satuan
    };
