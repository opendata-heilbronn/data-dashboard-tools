import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:opendata_parser/datenwaben.dart';
import 'dart:io';

readStolpersteine() async {
  var body = await http
      .read('http://stolpersteine-heilbronn.de/stolpersteine.geojson');
  var geojson = json.decode(body);

  num sum = 0;
  for (var feature in geojson['features']) {
    sum += feature["properties"]["names"].length;
  }

  Datenwabe datenwabe = Datenwabe.empty();

  Front front = datenwabe.front;
  front
    ..textTop = 'Heilbronn hat'
    ..value = '$sum'
    ..textBottom = 'Stolpersteine'
    ..format = 'int'
    ..background = 'img/template.svg'
    ..color = '#fff';

  Back back = datenwabe.back;
  back
    ..text =
        'Stolpersteine sind kleine Gedenktafeln über die Schicksale der Opfer des NS-Regimes, meist jüdischer Abstammung.'
    ..color = '#000';
  File file = File('stolpersteine.json');
  file.writeAsStringSync(json.encode(datenwabe.toJson()));
}
