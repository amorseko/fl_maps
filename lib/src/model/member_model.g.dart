// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberModels _$MemberModelsFromJson(Map<String, dynamic> json) {
  return MemberModels(
      code: json['code'] as int,
      message: json['message'] as String,
      status: json['status'] as bool,
      data: json['data'] == null
          ? null
          : _Data.fromJson(json['data'] as Map<String, dynamic>));
}

Map<String, dynamic> _$MemberModelsToJson(MemberModels instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'status': instance.status,
      'data': instance.data
    };

_Data _$_DataFromJson(Map<String, dynamic> json) {
  return _Data(
      username: json['username'] as String,
      level: json['level'] as String,
      id: json['id'] as String,
      name: json['name'] as String,
      is_active: json['is_active'] as String,
      pict: json['pict'] as String,
      images: json['images'] as String,
      no_hp: json['no_hp'] as String,
      no_telp: json['no_telp'] as String,
      id_provinsi: json['id_provinsi'] as String,
      id_kota: json['id_kota'] as String,
      id_gapoktan: json['id_gapoktan'] as String,
      lat: json['lat'] as String,
      long: json['long'] as String);
}

Map<String, dynamic> _$_DataToJson(_Data instance) => <String, dynamic>{
      'username': instance.username,
      'level': instance.level,
      'id': instance.id,
      'name': instance.name,
      'is_active': instance.is_active,
      'pict': instance.pict,
      'images': instance.images,
      'no_hp': instance.no_hp,
      'no_telp': instance.no_telp,
      'id_provinsi': instance.id_provinsi,
      'id_kota': instance.id_kota,
      'id_gapoktan': instance.id_gapoktan,
      'lat': instance.lat,
      'long': instance.long
    };
