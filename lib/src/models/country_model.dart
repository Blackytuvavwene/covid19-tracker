// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Country welcomeFromJson(String str) =>
    Country.fromJson(json.decode(str) as Map<String, String>);

String welcomeToJson(Country data) => json.encode(data.toJson());

class Country {
  Country({
    this.confirmed,
    this.recovered,
    this.deaths,
    this.country,
    this.population,
    this.sqKmArea,
    this.lifeExpectancy,
    this.elevationInMeters,
    this.continent,
    this.abbreviation,
    this.location,
    this.iso,
    this.capitalCity,
    this.lat,
    this.long,
    this.updated,
  });

  int? confirmed;
  int? recovered;
  int? deaths;
  String? country;
  int? population;
  int? sqKmArea;
  String? lifeExpectancy;
  String? elevationInMeters;
  String? continent;
  String? abbreviation;
  String? location;
  int? iso;
  String? capitalCity;
  String? lat;
  String? long;
  String? updated;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        confirmed: json['confirmed'] as int,
        recovered: json['recovered'] as int,
        deaths: json['deaths'] as int,
        country: json['country'].toString(),
        population: json['population'] as int,
        sqKmArea: json['sq_km_area'] as int,
        lifeExpectancy: json['life_expectancy'].toString(),
        elevationInMeters: json['elevation_in_meters'].toString(),
        continent: json['continent'].toString(),
        abbreviation: json['abbreviation'].toString(),
        location: json['location'].toString(),
        iso: json['iso'] as int,
        capitalCity: json['capital_city'].toString(),
        lat: json['lat'].toString(),
        long: json['long'].toString(),
        updated: json['updated'].toString(),
      );

  Map<String, dynamic> toJson() => {
        'confirmed': confirmed,
        'recovered': recovered,
        'deaths': deaths,
        'country': country,
        'population': population,
        'sq_km_area': sqKmArea,
        'life_expectancy': lifeExpectancy,
        'elevation_in_meters': elevationInMeters,
        'continent': continent,
        'abbreviation': abbreviation,
        'location': location,
        'iso': iso,
        'capital_city': capitalCity,
        'lat': lat,
        'long': long,
        'updated': updated,
      };
}
