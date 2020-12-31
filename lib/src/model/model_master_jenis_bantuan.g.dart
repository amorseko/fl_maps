// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_master_jenis_bantuan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetListMasterJenisBantuan _$GetListMasterJenisBantuanFromJson(
    Map<String, dynamic> json) {
  return GetListMasterJenisBantuan(
      message: json['message'] as String,
      status: json['status'] as String,
      data: (json['data'] as List)
          ?.map((e) => e == null
              ? null
              : ListMasterJenisBantuan.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      error: json['error'] as bool);
}

Map<String, dynamic> _$GetListMasterJenisBantuanToJson(
        GetListMasterJenisBantuan instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'error': instance.error,
      'data': instance.data
    };

ListMasterJenisBantuan _$ListMasterJenisBantuanFromJson(
    Map<String, dynamic> json) {
  return ListMasterJenisBantuan(
      id: json['id'] as String, name: json['name'] as String);
}

Map<String, dynamic> _$ListMasterJenisBantuanToJson(
        ListMasterJenisBantuan instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};
