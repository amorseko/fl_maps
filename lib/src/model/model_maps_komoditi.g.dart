// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_maps_komoditi.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetMapsKomoditiModels _$GetMapsKomoditiModelsFromJson(
    Map<String, dynamic> json) {
  return GetMapsKomoditiModels(
      status: json['status'] as String,
      error: json['error'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List)
          ?.map((e) => e == null
              ? null
              : ListMapsDataKomoditi.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$GetMapsKomoditiModelsToJson(
        GetMapsKomoditiModels instance) =>
    <String, dynamic>{
      'status': instance.status,
      'error': instance.error,
      'message': instance.message,
      'data': instance.data
    };

ListMapsDataKomoditi _$ListMapsDataKomoditiFromJson(Map<String, dynamic> json) {
  return ListMapsDataKomoditi(
      nama_kegiatan: json['nama_kegiatan'] as String,
      komoditi: json['komoditi'] as String,
      spesifikasi: json['spesifikasi'] as String,
      tahun: json['tahun'] as String,
      jumlah: json['jumlah'] as String,
      kapasitas: json['kapasitas'] as String,
      tahun_pembuatan: json['tahun_pembuatan'] as String,
      long: json['long'] as String,
      lat: json['lat'] as String,
      nama_gapoktan: json['nama_gapoktan'] as String,
      nama_produk: json['nama_produk'] as String,
      alamat: json['alamat'] as String,
      nama_pic: json['nama_pic'] as String,
      jenis_produk: json['jenis_produk'] as String,
      jenis_bantuan: json['jenis_bantuan'] as String,
      icon: json['icon'] as String,
      nama_komoditi: json['nama_komoditi'] as String);
}

Map<String, dynamic> _$ListMapsDataKomoditiToJson(
        ListMapsDataKomoditi instance) =>
    <String, dynamic>{
      'nama_kegiatan': instance.nama_kegiatan,
      'komoditi': instance.komoditi,
      'spesifikasi': instance.spesifikasi,
      'tahun': instance.tahun,
      'jumlah': instance.jumlah,
      'kapasitas': instance.kapasitas,
      'tahun_pembuatan': instance.tahun_pembuatan,
      'long': instance.long,
      'lat': instance.lat,
      'nama_gapoktan': instance.nama_gapoktan,
      'nama_produk': instance.nama_produk,
      'alamat': instance.alamat,
      'nama_pic': instance.nama_pic,
      'jenis_produk': instance.jenis_produk,
      'jenis_bantuan': instance.jenis_bantuan,
      'icon': instance.icon,
      'nama_komoditi': instance.nama_komoditi
    };
