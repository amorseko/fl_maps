// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_data_kinerja.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetModelDataKinerja _$GetModelDataKinerjaFromJson(Map<String, dynamic> json) {
  return GetModelDataKinerja(
      status: json['status'] as String,
      error: json['error'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List)
          ?.map((e) => e == null
              ? null
              : ListDataKinerja.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$GetModelDataKinerjaToJson(
        GetModelDataKinerja instance) =>
    <String, dynamic>{
      'status': instance.status,
      'error': instance.error,
      'message': instance.message,
      'data': instance.data
    };

ListDataKinerja _$ListDataKinerjaFromJson(Map<String, dynamic> json) {
  return ListDataKinerja(
      id_kinerja: json['id_kinerja'] as String,
      id_gapoktan: json['id_gapoktan'] as String,
      id_jenis_bantuan: json['id_jenis_bantuan'] as String,
      tanggal: json['tanggal'] as String,
      bentuk_hasil_olahan: json['bentuk_hasil_olahan'] as String,
      jumlah_diolah: json['jumlah_diolah'] as String,
      jumlah_hasil_olahan: json['jumlah_hasil_olahan'] as String,
      jumlah_dijual: json['jumlah_dijual'] as String,
      harga_produk: json['harga_produk'] as String,
      biaya_olah: json['biaya_olah'] as String,
      jumlah_penjualan: json['jumlah_penjualan'] as String,
      penghasilan_jasa_alat: json['penghasilan_jasa_alat'] as String,
      uang_kas: json['uang_kas'] as String,
      kondisi_alat: json['kondisi_alat'] as String,
      foto: json['foto'] as String,
      user_input: json['user_input'] as String,
      keterangan: json['keterangan'] as String,
      tanggal_input: json['tanggal_input'] as String,
      tanggal_modify: json['tanggal_modify'] as String,
      nama_gapoktan: json['nama_gapoktan'] as String,
      nama_bantuan: json['nama_bantuan'] as String);
}

Map<String, dynamic> _$ListDataKinerjaToJson(ListDataKinerja instance) =>
    <String, dynamic>{
      'id_kinerja': instance.id_kinerja,
      'id_gapoktan': instance.id_gapoktan,
      'id_jenis_bantuan': instance.id_jenis_bantuan,
      'tanggal': instance.tanggal,
      'bentuk_hasil_olahan': instance.bentuk_hasil_olahan,
      'jumlah_diolah': instance.jumlah_diolah,
      'jumlah_hasil_olahan': instance.jumlah_hasil_olahan,
      'jumlah_dijual': instance.jumlah_dijual,
      'harga_produk': instance.harga_produk,
      'biaya_olah': instance.biaya_olah,
      'jumlah_penjualan': instance.jumlah_penjualan,
      'penghasilan_jasa_alat': instance.penghasilan_jasa_alat,
      'uang_kas': instance.uang_kas,
      'kondisi_alat': instance.kondisi_alat,
      'foto': instance.foto,
      'user_input': instance.user_input,
      'keterangan': instance.keterangan,
      'tanggal_input': instance.tanggal_input,
      'tanggal_modify': instance.tanggal_modify,
      'nama_gapoktan': instance.nama_gapoktan,
      'nama_bantuan': instance.nama_bantuan
    };
