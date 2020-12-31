// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_get_bantuan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetModelBantuan _$GetModelBantuanFromJson(Map<String, dynamic> json) {
  return GetModelBantuan(
      status: json['status'] as String,
      error: json['error'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List)
          ?.map((e) => e == null
              ? null
              : GetListdataBantuan.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$GetModelBantuanToJson(GetModelBantuan instance) =>
    <String, dynamic>{
      'status': instance.status,
      'error': instance.error,
      'message': instance.message,
      'data': instance.data
    };

GetListdataBantuan _$GetListdataBantuanFromJson(Map<String, dynamic> json) {
  return GetListdataBantuan(
      id_bantuan: json['id_bantuan'] as String,
      id_gapoktan: json['id_gapoktan'] as String,
      id_jenis_bantuan: json['id_jenis_bantuan'] as String,
      spesifikasi: json['spesifikasi'] as String,
      tahun: json['tahun'] as String,
      jumlah: json['jumlah'] as String,
      kapasitas: json['kapasitas'] as String,
      kondisi: json['kondisi'] as String,
      asal_dana: json['asal_dana'] as String,
      tanggal_input: json['tanggal_input'] as String,
      foto: json['foto'] as String);
}

Map<String, dynamic> _$GetListdataBantuanToJson(GetListdataBantuan instance) =>
    <String, dynamic>{
      'id_bantuan': instance.id_bantuan,
      'id_gapoktan': instance.id_gapoktan,
      'id_jenis_bantuan': instance.id_jenis_bantuan,
      'spesifikasi': instance.spesifikasi,
      'tahun': instance.tahun,
      'jumlah': instance.jumlah,
      'kapasitas': instance.kapasitas,
      'kondisi': instance.kondisi,
      'asal_dana': instance.asal_dana,
      'tanggal_input': instance.tanggal_input,
      'foto': instance.foto
    };
