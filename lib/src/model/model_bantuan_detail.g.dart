// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_bantuan_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetModelBantuanDetail _$GetModelBantuanDetailFromJson(
    Map<String, dynamic> json) {
  return GetModelBantuanDetail(
      status: json['status'] as String,
      error: json['error'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List)
          ?.map((e) => e == null
              ? null
              : GetListdataBantuanDetail.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$GetModelBantuanDetailToJson(
        GetModelBantuanDetail instance) =>
    <String, dynamic>{
      'status': instance.status,
      'error': instance.error,
      'message': instance.message,
      'data': instance.data
    };

GetListdataBantuanDetail _$GetListdataBantuanDetailFromJson(
    Map<String, dynamic> json) {
  return GetListdataBantuanDetail(
      id_bantuan: json['id_bantuan'] as String,
      user_input: json['user_input'] as String,
      id_item_bantuan: json['id_item_bantuan'] as String,
      name: json['name'] as String,
      kapasitas_terpasang: json['kapasitas_terpasang'] as String,
      jumlah: json['jumlah'] as String,
      spesifikasi: json['spesifikasi'] as String,
      tahun_pembuatan: json['tahun_pembuatan'] as String);
}

Map<String, dynamic> _$GetListdataBantuanDetailToJson(
        GetListdataBantuanDetail instance) =>
    <String, dynamic>{
      'id_bantuan': instance.id_bantuan,
      'user_input': instance.user_input,
      'id_item_bantuan': instance.id_item_bantuan,
      'name': instance.name,
      'kapasitas_terpasang': instance.kapasitas_terpasang,
      'jumlah': instance.jumlah,
      'spesifikasi': instance.spesifikasi,
      'tahun_pembuatan': instance.tahun_pembuatan
    };
