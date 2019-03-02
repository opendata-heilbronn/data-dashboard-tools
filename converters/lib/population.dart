import 'dart:io';
import 'dart:convert';

import 'package:opendata_parser/datenwaben.dart';

readPopulation() async {
  List<int> file =
      await File('./lib/daten-stadt-heilbronn/population.json').readAsBytesSync();
  String data = latin1.decode(file);
  List<List<dynamic>> districts = [];
  List<dynamic> districtKeys = [];
  List<dynamic> districtSums = [];
  var sum;
  for (var line in json.decode(data)) {
    if (line["Alter"].toString() == 'Gesamt') {
      sum = line;
    } else if (line["Alter"].toString() == 'Summe') {
      districtSums.add(line);
    } else {
      if (line["Stadtteil"].toString().length > 0) {
        districts.add(List());
        districtKeys.add(line);
      }
      if (districts.length == 0) {
        districts.add(List());
      }
      districts[districts.length - 1].add(line);
    }
  }
  int totalPopulation = (sum['Gesamt'] * 1000).toInt();
  int totalMen = (sum['men'] * 1000).toInt();
  int totalWomen = (sum['women'] * 1000).toInt();
  int totalUnder18 = 0;
  int totalUnder14 = 0;
  for (var district in districts) {
    for (var line in district) {
      var age = line['Alter'];
      if (age != null) {
        int ageInt = 0;
        if (age is String) {
          if (age.length > 2) {
            age = age.substring(0, 2);
          }
          ageInt = int.tryParse(age);
          if (ageInt == null) {}
        } else if (age is double) {
          ageInt = age.toInt();
        } else if (age is int) {
          ageInt = age;
        } else {
          throw 'Fehler!!';
        }
        if (ageInt < 18) {
          totalUnder18 += line["Gesamt"].toInt();
        }
        if (ageInt < 14) {
          totalUnder14 += line["Gesamt"].toInt();
        }
      }
    }
  }
  print('Gesamt $totalPopulation');
  print('männlich $totalMen');
  print('weiblich $totalWomen');
  print('U18 $totalUnder18');
  print('U14 $totalUnder14');

  List<Datenwabe> waben = [];

  Datenwabe populationWabe = Datenwabe.empty();
  populationWabe.front
    ..textTop = 'Heilbronn hat'
    ..value = '$totalPopulation'
    ..textBottom = 'Einwohner'
    ..format = 'int'
    ..background = 'img/family.svg'
    ..color = '#fff';
  populationWabe.back
    ..text = 'Stand 12/2018.'
    ..color = '#000';
  waben.add(populationWabe);

  Datenwabe u14Wabe = Datenwabe.empty();
  u14Wabe.front
    ..textTop = 'Heilbronn hat'
    ..value = '$totalUnder14'
    ..textBottom = 'Einwohner unter 14 Jahren'
    ..format = 'int'
    ..background = 'img/family.svg'
    ..color = '#fff';
  u14Wabe.back
    ..text = 'Stand 12/2018.'
    ..color = '#000';
  waben.add(u14Wabe);

  Datenwabe u18Wabe = Datenwabe.empty();
  u18Wabe.front
    ..textTop = 'Heilbronn hat'
    ..value = '$totalUnder18'
    ..textBottom = 'Einwohner unter 18 Jahren'
    ..format = 'int'
    ..background = 'img/family.svg'
    ..color = '#fff';
  u18Wabe.back
    ..text = 'Stand 12/2018.'
    ..color = '#000';
  waben.add(u18Wabe);

  Datenwabe womenWabe = Datenwabe.empty();
  womenWabe.front
    ..textTop = 'Heilbronn hat'
    ..value = '${totalWomen / totalPopulation * 100}'
    ..textBottom = 'Prozent Frauen'
    ..format = 'int'
    ..background = 'img/gender.svg'
    ..color = '#fff';
  womenWabe.back
    ..text = 'Stand 12/2018.'
    ..color = '#000';

  waben.add(womenWabe);

  for (Datenwabe wabe in waben) {
    String name = wabe.front.textBottom
        .replaceAll(" ", "-")
        .toLowerCase()
        .replaceAll("ö", "oe")
        .replaceAll("ä", "ae")
        .replaceAll("ü", "ue");
    File file = File('${name}.json');
    file.writeAsStringSync(json.encode(wabe.toJson()));
  }
}
