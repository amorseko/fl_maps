// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_bantuan_new.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetModelBantuanNew _$GetModelBantuanNewFromJson(Map<String, dynamic> json) {
  return GetModelBantuanNew(
      status: json['status'] as String,
      error: json['error'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List)
          ?.map((e) => e == null
              ? null
              : GetListdataBantuanNew.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$GetModelBantuanNewToJson(GetModelBantuanNew instance) =>
    <String, dynamic>{
      'status': instance.status,
      'error': instance.error,
      'message': instance.message,
      'data': instance.data
    };

GetListdataBantuanNew _$GetListdataBantuanNewFromJson(
    Map<String, dynamic> json) {
  return GetListdataBantuanNew(
      id_bantuan: json['id_bantuan'] as String,
      user_input: json['user_input'] as String,
      nama_kegiatan: json['nama_kegiatan'] as String,
      nama_gapoktan: json['nama_gapoktan'] as String,
      nomor_spk: json['nomor_spk'] as String,
      tahap_bantuan: json['tahap_bantuan'] as String)
    ..tahun = json['tahun'] as String;
}

Map<String, dynamic> _$GetListdataBantuanNewToJson(
        GetListdataBantuanNew instance) =>
    <String, dynamic>{
      'id_bantuan': instance.id_bantuan,
      'user_input': instance.user_input,
      'nama_kegiatan': instance.nama_kegiatan,
      'nama_gapoktan': instance.nama_gapoktan,
      'nomor_spk': instance.nomor_spk,
      'tahun': instance.tahun,
      'tahap_bantuan': instance.tahap_bantuan
    };
