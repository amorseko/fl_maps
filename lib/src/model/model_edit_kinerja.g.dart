// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_edit_kinerja.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetModelEditKinerja _$GetModelEditKinerjaFromJson(Map<String, dynamic> json) {
  return GetModelEditKinerja(
      status: json['status'] as String,
      error: json['error'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List)
          ?.map((e) => e == null
              ? null
              : ListKinerjaDataEdit.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$GetModelEditKinerjaToJson(
        GetModelEditKinerja instance) =>
    <String, dynamic>{
      'status': instance.status,
      'error': instance.error,
      'message': instance.message,
      'data': instance.data
    };

ListKinerjaDataEdit _$ListKinerjaDataEditFromJson(Map<String, dynamic> json) {
  return ListKinerjaDataEdit(
      id_kinerja: json['id_kinerja'] as String,
      nama_gapoktan: json['nama_gapoktan'] as String,
      nama_jenis_bantuan: json['nama_jenis_bantuan'] as String,
      name_proses: json['name_proses'] as String,
      kapasitas_terpasang: json['kapasitas_terpasang'] as String,
      jumlah_bb: json['jumlah_bb'] as String,
      hasil_olahan: json['hasil_olahan'] as String,
      jumlah_olahan: json['jumlah_olahan'] as String,
      tanggal_input: json['tanggal_input'] as String,
      foto: json['foto'] as String,
      user_input: json['user_input'] as String,
      id_gapoktan: json['id_gapoktan'] as String,
      id_jenis_bantuan: json['id_jenis_bantuan'] as String,
      id_jenis_proses: json['id_jenis_proses'] as String);
}

Map<String, dynamic> _$ListKinerjaDataEditToJson(
        ListKinerjaDataEdit instance) =>
    <String, dynamic>{
      'id_kinerja': instance.id_kinerja,
      'nama_gapoktan': instance.nama_gapoktan,
      'nama_jenis_bantuan': instance.nama_jenis_bantuan,
      'name_proses': instance.name_proses,
      'kapasitas_terpasang': instance.kapasitas_terpasang,
      'jumlah_bb': instance.jumlah_bb,
      'hasil_olahan': instance.hasil_olahan,
      'jumlah_olahan': instance.jumlah_olahan,
      'tanggal_input': instance.tanggal_input,
      'foto': instance.foto,
      'user_input': instance.user_input,
      'id_gapoktan': instance.id_gapoktan,
      'id_jenis_bantuan': instance.id_jenis_bantuan,
      'id_jenis_proses': instance.id_jenis_proses
    };
