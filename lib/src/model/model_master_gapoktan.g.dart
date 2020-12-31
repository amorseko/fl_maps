// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_master_gapoktan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetListMasterGapoktanData _$GetListMasterGapoktanDataFromJson(
    Map<String, dynamic> json) {
  return GetListMasterGapoktanData(
      message: json['message'] as String,
      status: json['status'] as String,
      data: (json['data'] as List)
          ?.map((e) => e == null
              ? null
              : ListMasterGapoktan.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      error: json['error'] as bool);
}

Map<String, dynamic> _$GetListMasterGapoktanDataToJson(
        GetListMasterGapoktanData instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'error': instance.error,
      'data': instance.data
    };

ListMasterGapoktan _$ListMasterGapoktanFromJson(Map<String, dynamic> json) {
  return ListMasterGapoktan(
      id_gapoktan: json['id_gapoktan'] as String,
      nama_gapoktan: json['nama_gapoktan'] as String);
}

Map<String, dynamic> _$ListMasterGapoktanToJson(ListMasterGapoktan instance) =>
    <String, dynamic>{
      'id_gapoktan': instance.id_gapoktan,
      'nama_gapoktan': instance.nama_gapoktan
    };
