// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datenwaben.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Datenwabe _$DatenwabeFromJson(Map<String, dynamic> json) {
  return Datenwabe(
      location: Location.fromJson(json['location'] as Map<String, dynamic>),
      portal: Portal.fromJson(json['portal'] as Map<String, dynamic>),
      back: Back.fromJson(json['back'] as Map<String, dynamic>),
      front: Front.fromJson(json['front'] as Map<String, dynamic>));
}

Map<String, dynamic> _$DatenwabeToJson(Datenwabe instance) => <String, dynamic>{
      'location': instance.location,
      'portal': instance.portal,
      'back': instance.back,
      'front': instance.front
    };

Location _$LocationFromJson(Map<String, dynamic> json) {
  return Location(
      country: json['country'] as String, city: json['city'] as String);
}

Map<String, dynamic> _$LocationToJson(Location instance) =>
    <String, dynamic>{'country': instance.country, 'city': instance.city};

Portal _$PortalFromJson(Map<String, dynamic> json) {
  return Portal(
      url: json['url'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      license: json['license'] as String,
      licenseURL: json['licenseURL'] as String);
}

Map<String, dynamic> _$PortalToJson(Portal instance) => <String, dynamic>{
      'url': instance.url,
      'title': instance.title,
      'description': instance.description,
      'license': instance.license,
      'licenseURL': instance.licenseURL
    };

Front _$FrontFromJson(Map<String, dynamic> json) {
  return Front(
      textTop: json['textTop'] as String,
      textBottom: json['textBottom'] as String,
      value: json['value'] as String,
      unit: json['unit'] as String,
      changePerDay: json['changePerDay'] as String,
      format: json['format'] as String,
      background: json['background'] as String,
      color: json['color'] as String);
}

Map<String, dynamic> _$FrontToJson(Front instance) => <String, dynamic>{
      'textTop': instance.textTop,
      'textBottom': instance.textBottom,
      'value': instance.value,
      'unit': instance.unit,
      'changePerDay': instance.changePerDay,
      'format': instance.format,
      'background': instance.background,
      'color': instance.color
    };

Back _$BackFromJson(Map<String, dynamic> json) {
  return Back(
      text: json['text'] as String,
      color: json['color'] as String,
      cssClass: json['cssClass'] as String);
}

Map<String, dynamic> _$BackToJson(Back instance) => <String, dynamic>{
      'text': instance.text,
      'color': instance.color,
      'cssClass': instance.cssClass
    };
