// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_edit_gapoktan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetModelEditGapoktan _$GetModelEditGapoktanFromJson(Map<String, dynamic> json) {
  return GetModelEditGapoktan(
      status: json['status'] as String,
      error: json['error'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List)
          ?.map((e) => e == null
              ? null
              : ListGapoktanDataEdit.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$GetModelEditGapoktanToJson(
        GetModelEditGapoktan instance) =>
    <String, dynamic>{
      'status': instance.status,
      'error': instance.error,
      'message': instance.message,
      'data': instance.data
    };

ListGapoktanDataEdit _$ListGapoktanDataEditFromJson(Map<String, dynamic> json) {
  return ListGapoktanDataEdit(
      id_gapoktan: json['id_gapoktan'] as String,
      id_provinsi: json['id_provinsi'] as String,
      id_komoditi: json['id_komoditi'] as String,
      id_kota: json['id_kota'] as String,
      nama_produk: json['nama_produk'] as String,
      nama_gapoktan: json['nama_gapoktan'] as String,
      alamat: json['alamat'] as String,
      nama_pic: json['nama_pic'] as String,
      no_pic: json['no_pic'] as String,
      jenis_produk: json['jenis_produk'] as String,
      kapasitas: json['kapasitas'] as String,
      pasar: json['pasar'] as String,
      kemitraan: json['kemitraan'] as String);
}

Map<String, dynamic> _$ListGapoktanDataEditToJson(
        ListGapoktanDataEdit instance) =>
    <String, dynamic>{
      'id_gapoktan': instance.id_gapoktan,
      'id_provinsi': instance.id_provinsi,
      'id_komoditi': instance.id_komoditi,
      'id_kota': instance.id_kota,
      'nama_produk': instance.nama_produk,
      'nama_gapoktan': instance.nama_gapoktan,
      'alamat': instance.alamat,
      'nama_pic': instance.nama_pic,
      'no_pic': instance.no_pic,
      'jenis_produk': instance.jenis_produk,
      'kapasitas': instance.kapasitas,
      'pasar': instance.pasar,
      'kemitraan': instance.kemitraan
    };
