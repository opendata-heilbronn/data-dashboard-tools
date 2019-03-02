# Restaurants-Utility
Teilt die von OpenStreetMap abgerufenen Restaurants in Stadtteile auf

## Verwendung

Mittels Overpass Turbo folgende Query ausführen, als GeoJSON exportieren und als `restaurants.json` im src Ordner ablegen

```
(
  node["amenity"="restaurant"]["addr:city"="Heilbronn"];
  node["amenity"="pub"]["addr:city"="Heilbronn"];
  node["amenity"="bbq"]["addr:city"="Heilbronn"];
  node["amenity"="bar"]["addr:city"="Heilbronn"];
  node["amenity"="fast_food"]["addr:city"="Heilbronn"];
  node["amenity"="food_court"]["addr:city"="Heilbronn"];
  node["amenity"="biergarten"]["addr:city"="Heilbronn"];
  node["amenity"="cafe"]["addr:city"="Heilbronn"];
);
out;
```

Die Datei `Stadtteilgrenzen_Heilbronn.geojson` der Stadt Heilbronn (für Code for Heilbronn zur Verfügung gestellt, leider nicht öffentlich) als `Stadtteilgrenzen_Heilbronn.json` im src Ordner ablegen.

`node src/index.js` ausführen. Die aufgeteilte Liste wird ausgegeben.
