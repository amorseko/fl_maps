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
      gapoktan: json['gapoktan'] as String);
}

Map<String, dynamic> _$ListMapsDataToJson(ListMapsData instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'long': instance.long,
      'gapoktan': instance.gapoktan
    };
