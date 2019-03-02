// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geojson.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Feature _$FeatureFromJson(Map<String, dynamic> json) {
  return Feature()
    ..type = json['type'] as String
    ..properties = json['properties'] as Map<String, dynamic>;
}

Map<String, dynamic> _$FeatureToJson(Feature instance) =>
    <String, dynamic>{'type': instance.type, 'properties': instance.properties};
