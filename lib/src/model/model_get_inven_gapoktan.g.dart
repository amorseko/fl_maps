// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_get_inven_gapoktan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetModelInvenGapoktan _$GetModelInvenGapoktanFromJson(
    Map<String, dynamic> json) {
  return GetModelInvenGapoktan(
      status: json['status'] as String,
      error: json['error'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List)
          ?.map((e) => e == null
              ? null
              : GetListdatInvenGapoktan.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$GetModelInvenGapoktanToJson(
        GetModelInvenGapoktan instance) =>
    <String, dynamic>{
      'status': instance.status,
      'error': instance.error,
      'message': instance.message,
      'data': instance.data
    };

GetListdatInvenGapoktan _$GetListdatInvenGapoktanFromJson(
    Map<String, dynamic> json) {
  return GetListdatInvenGapoktan(
      id_inventaris: json['id_inventaris'] as String,
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
      foto: json['foto'] as String,
      file_penunjang: json['file_penunjang'] as String,
      is_bantuan: json['is_bantuan'] as String,
      pemanfaatan: json['pemanfaatan'] as String)
    ..tahun_pembuatan = json['tahun_pembuatan'] as String;
}

Map<String, dynamic> _$GetListdatInvenGapoktanToJson(
        GetListdatInvenGapoktan instance) =>
    <String, dynamic>{
      'id_inventaris': instance.id_inventaris,
      'id_gapoktan': instance.id_gapoktan,
      'id_jenis_bantuan': instance.id_jenis_bantuan,
      'spesifikasi': instance.spesifikasi,
      'tahun': instance.tahun,
      'tahun_pembuatan': instance.tahun_pembuatan,
      'jumlah': instance.jumlah,
      'kapasitas': instance.kapasitas,
      'kondisi': instance.kondisi,
      'asal_dana': instance.asal_dana,
      'tanggal_input': instance.tanggal_input,
      'foto': instance.foto,
      'id_bantuan': instance.id_bantuan,
      'file_penunjang': instance.file_penunjang,
      'is_bantuan': instance.is_bantuan,
      'pemanfaatan': instance.pemanfaatan
    };
