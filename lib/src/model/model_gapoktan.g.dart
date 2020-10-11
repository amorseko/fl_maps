// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_gapoktan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetModelGapoktan _$GetModelGapoktanFromJson(Map<String, dynamic> json) {
  return GetModelGapoktan(
      status: json['status'] as String,
      error: json['error'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List)
          ?.map((e) => e == null
              ? null
              : ListGapoktanData.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$GetModelGapoktanToJson(GetModelGapoktan instance) =>
    <String, dynamic>{
      'status': instance.status,
      'error': instance.error,
      'message': instance.message,
      'data': instance.data
    };

ListGapoktanData _$ListGapoktanDataFromJson(Map<String, dynamic> json) {
  return ListGapoktanData(
      gapoktan: json['gapoktan'] as String,
      id_gapoktan: json['id_gapoktan'] as String,
      nama_provinsi: json['nama_provinsi'] as String,
      nama_komoditi: json['nama_komoditi'] as String,
      nama_produk: json['nama_produk'] as String);
}

Map<String, dynamic> _$ListGapoktanDataToJson(ListGapoktanData instance) =>
    <String, dynamic>{
      'id_gapoktan': instance.id_gapoktan,
      'gapoktan': instance.gapoktan,
      'nama_provinsi': instance.nama_provinsi,
      'nama_komoditi': instance.nama_komoditi,
      'nama_produk': instance.nama_produk
    };
