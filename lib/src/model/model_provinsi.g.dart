// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_provinsi.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetListModelProvinsi _$GetListModelProvinsiFromJson(Map<String, dynamic> json) {
  return GetListModelProvinsi(
      message: json['message'] as String,
      status: json['status'] as String,
      data: (json['data'] as List)
          ?.map((e) =>
              e == null ? null : _Data.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      error: json['error'] as bool);
}

Map<String, dynamic> _$GetListModelProvinsiToJson(
        GetListModelProvinsi instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'error': instance.error,
      'data': instance.data
    };

_Data _$_DataFromJson(Map<String, dynamic> json) {
  return _Data(
      id_prov: json['id_prov'] as String, nama: json['nama'] as String);
}

Map<String, dynamic> _$_DataToJson(_Data instance) =>
    <String, dynamic>{'id_prov': instance.id_prov, 'nama': instance.nama};
