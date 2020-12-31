// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_maps_gapoktan_new.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetMapsGapoktanModels _$GetMapsGapoktanModelsFromJson(
    Map<String, dynamic> json) {
  return GetMapsGapoktanModels(
      status: json['status'] as String,
      error: json['error'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List)
          ?.map((e) => e == null
              ? null
              : ListMapsDataGapoktan.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$GetMapsGapoktanModelsToJson(
        GetMapsGapoktanModels instance) =>
    <String, dynamic>{
      'status': instance.status,
      'error': instance.error,
      'message': instance.message,
      'data': instance.data
    };

ListMapsDataGapoktan _$ListMapsDataGapoktanFromJson(Map<String, dynamic> json) {
  return ListMapsDataGapoktan(
      lat: json['lat'] as String,
      long: json['long'] as String,
      gapoktan: json['gapoktan'] as String,
      nama_produk: json['nama_produk'] as String,
      jenis_produk: json['jenis_produk'] as String,
      alamat: json['alamat'] as String,
      nama_pic: json['nama_pic'] as String,
      no_pic: json['no_pic'] as String,
      no_telp: json['no_telp'] as String,
      nama_kota: json['nama_kota'] as String,
      nama_provinsi: json['nama_provinsi'] as String,
      icon: json['icon'] as String,
      icon_default: json['icon_default'] as String,
      nama_komoditi: json['nama_komoditi'] as String);
}

Map<String, dynamic> _$ListMapsDataGapoktanToJson(
        ListMapsDataGapoktan instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'long': instance.long,
      'gapoktan': instance.gapoktan,
      'nama_produk': instance.nama_produk,
      'alamat': instance.alamat,
      'nama_pic': instance.nama_pic,
      'no_pic': instance.no_pic,
      'no_telp': instance.no_telp,
      'nama_kota': instance.nama_kota,
      'nama_provinsi': instance.nama_provinsi,
      'icon': instance.icon,
      'jenis_produk': instance.jenis_produk,
      'icon_default': instance.icon_default,
      'nama_komoditi': instance.nama_komoditi
    };
