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

void writeTreeDatenwabe(
    String prefix, String label, int trees, String textBottom,
    {String backText}) {
  Datenwabe datenwabe = Datenwabe.empty();

  Front front = datenwabe.front;
  front
    ..textTop = "Es gibt über"
    ..value = "$trees"
    ..textBottom = textBottom
    ..format = "int"
    ..background = "img/tree.svg"
    ..color = "#ffffff";

  Back back = datenwabe.back;
  back.text = backText ?? "Das Baumkataster hat den Datenstand von 2017";
  back.color = "#000000";

  File file = File("$prefix $label.json"
      .replaceAll(" ", "-")
      .toLowerCase()
      .replaceAll("ö", "oe")
      .replaceAll("ä", "ae")
      .replaceAll("ü", "ue"));
  file.writeAsStringSync(json.encode(datenwabe.toJson()));
}

void readGeoJson() async {
  File geojson = new File('baumkataster_022017.geojson');
  String data = await geojson.readAsString();
  Map<String, dynamic> treeGeojson = json.decode(data);
  List<Feature> features = (treeGeojson["features"] as List)
      .map((element) => Feature.fromJson(element))
      .toList();

  Map<String, List<Feature>> perStadtTeil = {};
  Map<String, int> treeKindCounter = {};
  for (Feature feature in features) {
    String stadtTeil = getStadtteil(feature.properties);
    List<Feature> stadtTeilFeatures =
        perStadtTeil.putIfAbsent(stadtTeil, () => []);
    stadtTeilFeatures.add(feature);

    String deuText = feature.properties["DEU_TEXT"];

    int counter = treeKindCounter.putIfAbsent(deuText, () => 0);
    treeKindCounter[deuText] = counter + 1;
  }

  for (MapEntry<String, List<Feature>> mapEntry in perStadtTeil.entries) {
    if (mapEntry.key != null) {
      print("${mapEntry.key} => ${mapEntry.value.length}");
      writeTreeDatenwabe("trees", mapEntry.key, mapEntry.value.length,
          "Bäume in " + mapEntry.key);
    }
  }

  List<MapEntry<String, int>> treeKinds =
      treeKindCounter.entries.where((entry) => entry.value > 1000).toList();
  treeKinds.sort((k1, k2) => k1.value - k2.value);

  int order = 1;
  for (MapEntry<String, int> mapEntry in treeKinds) {
    print("${mapEntry.key} => ${mapEntry.value}");
    writeTreeDatenwabe(
        "treekinds", mapEntry.key, mapEntry.value, mapEntry.key + " Bäume",
        backText:
            "${mapEntry.key} ist auf Rang $order bei der Baumart in Heilbronn");

    order++;
  }
}
