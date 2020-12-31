// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_maps.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetMapsPartModels _$GetMapsPartModelsFromJson(Map<String, dynamic> json) {
  return GetMapsPartModels(
      status: json['status'] as String,
      error: json['error'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List)
          ?.map((e) => e == null
              ? null
              : ListMapsData.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$GetMapsPartModelsToJson(GetMapsPartModels instance) =>
    <String, dynamic>{
      'status': instance.status,
      'error': instance.error,
      'message': instance.message,
      'data': instance.data
    };

ListMapsData _$ListMapsDataFromJson(Map<String, dynamic> json) {
  return ListMapsData(
      lat: json['lat'] as String,
      long: json['long'] as String,
      gapoktan: json['gapoktan'] as String,
      nama_kegiatan: json['nama_kegiatan'] as String,
      nomor_spk: json['nomor_spk'] as String,
      nama_produk: json['nama_produk'] as String,
      alamat: json['alamat'] as String,
      nama_pic: json['nama_pic'] as String,
      no_pic: json['no_pic'] as String,
      no_telp: json['no_telp'] as String,
      nama_kota: json['nama_kota'] as String,
      nama_provinsi: json['nama_provinsi'] as String,
      icon_bantuan: json['icon_bantuan'] as String,
      nama_komoditi: json['nama_komoditi'] as String);
}

Map<String, dynamic> _$ListMapsDataToJson(ListMapsData instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'long': instance.long,
      'gapoktan': instance.gapoktan,
      'nama_kegiatan': instance.nama_kegiatan,
      'nomor_spk': instance.nomor_spk,
      'nama_produk': instance.nama_produk,
      'alamat': instance.alamat,
      'nama_pic': instance.nama_pic,
      'no_pic': instance.no_pic,
      'no_telp': instance.no_telp,
      'nama_kota': instance.nama_kota,
      'nama_provinsi': instance.nama_provinsi,
      'icon_bantuan': instance.icon_bantuan,
      'nama_komoditi': instance.nama_komoditi
    };
