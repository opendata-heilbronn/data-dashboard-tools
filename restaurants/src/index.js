const booleanContains = require('@turf/boolean-contains');
const restaurants = require('./restaurants.json');
const stadtteileGeoJSON = require('./Stadtteilgrenzen_Heilbronn.json');

const stadtteile = stadtteileGeoJSON.features.map(stadtteil => ({
	name: stadtteil.properties.ORTSTEIL,
	feature: stadtteil,
	restaurants: []
})).reduce((dict, info) => {
	dict[info.name] = info;
	return dict;
}, {});


const restaurantsInDistricts = restaurants.features.reduce((districts, restaurant) => {
	for(let key of Object.keys(districts)) {
		if(booleanContains.default(districts[key].feature, restaurant)) {
			districts[key].restaurants.push(restaurant);
			break;
		}
	}
	return districts;
}, stadtteile);

Object.keys(restaurantsInDistricts).forEach(d => {
	console.log(restaurantsInDistricts[d].name, restaurantsInDistricts[d].restaurants.length);
});
console.log('Total', restaurants.features.length)
