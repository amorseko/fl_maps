// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_list_bantuan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetListBantuanModel _$GetListBantuanModelFromJson(Map<String, dynamic> json) {
  return GetListBantuanModel(
      message: json['message'] as String,
      status: json['status'] as String,
      data: (json['data'] as List)
          ?.map((e) => e == null
              ? null
              : ListBantuanData.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      error: json['error'] as bool);
}

Map<String, dynamic> _$GetListBantuanModelToJson(
        GetListBantuanModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'error': instance.error,
      'data': instance.data
    };

ListBantuanData _$ListBantuanDataFromJson(Map<String, dynamic> json) {
  return ListBantuanData(
      id_bantuan: json['id_bantuan'] as String,
      nama_gapoktan: json['nama_gapoktan'] as String,
      nama_bantuan: json['nama_bantuan'] as String,
      spesifikasi: json['spesifikasi'] as String,
      tahun: json['tahun'] as String,
      asal_dana: json['asal_dana'] as String);
}

Map<String, dynamic> _$ListBantuanDataToJson(ListBantuanData instance) =>
    <String, dynamic>{
      'id_bantuan': instance.id_bantuan,
      'nama_gapoktan': instance.nama_gapoktan,
      'nama_bantuan': instance.nama_bantuan,
      'spesifikasi': instance.spesifikasi,
      'tahun': instance.tahun,
      'asal_dana': instance.asal_dana
    };
