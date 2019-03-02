import 'dart:io';
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:tree_parser/datenwaben.dart';

part 'geojson.g.dart';

@JsonSerializable(nullable: false)
class Feature {
  String type;
  Map<String, dynamic> properties;

  Feature();

  factory Feature.fromJson(Map<String, dynamic> json) =>
      _$FeatureFromJson(json);
}

String getStadtteil(Map<String, dynamic> properties) {
  return properties["STADTTEIL"];
}

void readGeoJson() async {
  File geojson = new File('baumkataster_022017.geojson');
  String data = await geojson.readAsString();
  Map<String, dynamic> treeGeojson = json.decode(data);
  List<Feature> features = (treeGeojson["features"] as List)
      .map((element) => Feature.fromJson(element))
      .toList();

  Map<String, List<Feature>> perStadtTeil = {};
  for (Feature feature in features) {
    String stadtTeil = getStadtteil(feature.properties);
    List<Feature> stadtTeilFeatures =
        perStadtTeil.putIfAbsent(stadtTeil, () => []);
    stadtTeilFeatures.add(feature);
  }

  List<Datenwabe> datenwaben = [];

  for (MapEntry<String, List<Feature>> mapEntry in perStadtTeil.entries) {
    if (mapEntry.key != null) {
      print("${mapEntry.key} => ${mapEntry.value.length}");

      Datenwabe datenwabe = Datenwabe.empty();

      Front front = datenwabe.front;
      front.textTop = "Es gibt über";
      front.value = "${mapEntry.value.length}";
      front.textBottom = "in " + mapEntry.key;
      front.format = "int";
      front.background = "img/tree.svg";
      front.color = "#ffffff";

      Back back = datenwabe.back;
      back.text = "Das Baumkataster hat den Datenstand von 2017";
      back.color = "#000000";
      datenwaben.add(datenwabe);

      File file = File("trees ${mapEntry.key}.json"
          .replaceAll(" ", "-")
          .toLowerCase()
          .replaceAll("ö", "oe")
          .replaceAll("ä", "ae")
          .replaceAll("ü", "ue"));
      file.writeAsStringSync(json.encode(datenwabe.toJson()));
    }
  }
}
