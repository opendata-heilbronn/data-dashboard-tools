import 'package:json_annotation/json_annotation.dart';

part 'datenwaben.g.dart';

@JsonSerializable(nullable: false)
class Datenwabe {
  Location location = Location.empty();
  Portal portal = Portal.empty();
  Back back = Back.empty();
  Front front = Front.empty();

  Datenwabe.empty();

  Datenwabe({this.location, this.portal, this.back, this.front});

  Map<String, dynamic> toJson() => _$DatenwabeToJson(this);
}

@JsonSerializable(nullable: false)
class Location {
  String country = "Germany";
  String city = "Heilbronn";

  Location.empty();

  Location({this.country, this.city});

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);
}

@JsonSerializable(nullable: false)
class Portal {
  String url = "";
  String title = "";
  String description = "";
  String license = "";
  String licenseURL = "";

  Portal.empty();

  Portal(
      {this.url, this.title, this.description, this.license, this.licenseURL});

  factory Portal.fromJson(Map<String, dynamic> json) => _$PortalFromJson(json);
  Map<String, dynamic> toJson() => _$PortalToJson(this);
}

@JsonSerializable(nullable: false)
class Front {
  String textTop = "";
  String textBottom = "";
  String value = "";
  String unit = "";
  String changePerDay = "";
  String format = "";
  String background = "";
  String color = "";

  Front.empty();

  Front(
      {this.textTop,
      this.textBottom,
      this.value,
      this.unit,
      this.changePerDay,
      this.format,
      this.background,
      this.color});

  factory Front.fromJson(Map<String, dynamic> json) => _$FrontFromJson(json);

  Map<String, dynamic> toJson() => _$FrontToJson(this);
}

@JsonSerializable(nullable: false)
class Back {
  String text = "";
  String color = "";
  String cssClass = "";

  Back.empty();

  Back({this.text, this.color, this.cssClass});
  factory Back.fromJson(Map<String, dynamic> json) => _$BackFromJson(json);

  Map<String, dynamic> toJson() => _$BackToJson(this);
}
