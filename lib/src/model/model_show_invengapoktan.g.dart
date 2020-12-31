// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_show_invengapoktan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetModelListInvenGapoktan _$GetModelListInvenGapoktanFromJson(
    Map<String, dynamic> json) {
  return GetModelListInvenGapoktan(
      status: json['status'] as String,
      error: json['error'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List)
          ?.map((e) => e == null
              ? null
              : ListInvenGapoktan.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$GetModelListInvenGapoktanToJson(
        GetModelListInvenGapoktan instance) =>
    <String, dynamic>{
      'status': instance.status,
      'error': instance.error,
      'message': instance.message,
      'data': instance.data
    };

ListInvenGapoktan _$ListInvenGapoktanFromJson(Map<String, dynamic> json) {
  return ListInvenGapoktan(
      id_inventaris: json['id_inventaris'] as String,
      nama_gapoktan: json['nama_gapoktan'] as String,
      nama_bantuan: json['nama_bantuan'] as String,
      spesifikasi: json['spesifikasi'] as String,
      tahun: json['tahun'] as String,
      asal_dana: json['asal_dana'] as String);
}

Map<String, dynamic> _$ListInvenGapoktanToJson(ListInvenGapoktan instance) =>
    <String, dynamic>{
      'id_inventaris': instance.id_inventaris,
      'nama_gapoktan': instance.nama_gapoktan,
      'nama_bantuan': instance.nama_bantuan,
      'spesifikasi': instance.spesifikasi,
      'tahun': instance.tahun,
      'asal_dana': instance.asal_dana
    };
