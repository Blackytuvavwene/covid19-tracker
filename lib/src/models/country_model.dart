// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Country countryDataFromJson(String str) =>
    Country.fromJson(json.decode(str) as Map<String, dynamic>);

String countryDataToJson(Country data) => json.encode(data.toJson());

class Country {
  final CountryData? countryData;
  Country({
    this.countryData,
  });

  Map<String, dynamic> toJson() {
    return {
      'All': countryData?.toJson(),
    };
  }

  factory Country.fromJson(Map<String, dynamic> map) {
    return Country(
      countryData: CountryData.fromJson(map['All'] as Map<String, dynamic>),
    );
  }
}

class CountryData {
  CountryData({
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

  factory CountryData.fromJson(Map<String, dynamic> json) => CountryData(
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

//vaccines model for country

VaccineCountryData vaccineCountryDataFromJson(String str) =>
    VaccineCountryData.fromJson(json.decode(str) as Map<String, dynamic>);

String vaccineCountryDataToJson(VaccineCountryData data) =>
    json.encode(data.toJson());

class VaccineCountryData {
  VaccineCountryData({
    this.all,
  });

  CountryVaccine? all;

  factory VaccineCountryData.fromJson(Map<String, dynamic> json) =>
      VaccineCountryData(
        all: CountryVaccine.fromJson(json['All'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'All': all?.toJson(),
      };
}

class CountryVaccine {
  CountryVaccine({
    this.administered,
    this.peopleVaccinated,
    this.peoplePartiallyVaccinated,
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
    this.updated,
  });

  int? administered;
  int? peopleVaccinated;
  int? peoplePartiallyVaccinated;
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
  String? updated;

  factory CountryVaccine.fromJson(Map<String, dynamic> json) => CountryVaccine(
        administered: json['administered'] as int?,
        peopleVaccinated: json['people_vaccinated'] as int?,
        peoplePartiallyVaccinated: json['people_partially_vaccinated'] as int?,
        country: json['country'] as String?,
        population: json['population'] as int?,
        sqKmArea: json['sq_km_area'] as int?,
        lifeExpectancy: json['life_expectancy'] as String?,
        elevationInMeters: json['elevation_in_meters'] as String?,
        continent: json['continent'] as String?,
        abbreviation: json['abbreviation'] as String?,
        location: json['location'] as String?,
        iso: json['iso'] as int?,
        capitalCity: json['capital_city'] as String?,
        updated: json['updated'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'administered': administered,
        'people_vaccinated': peopleVaccinated,
        'people_partially_vaccinated': peoplePartiallyVaccinated,
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
        'updated': updated,
      };
}

//country death history

CovidDeathHistory covidDeathHistoryFromJson(String str) =>
    CovidDeathHistory.fromJson(json.decode(str) as Map<String, dynamic>);

String covidDeathHistoryToJson(CovidDeathHistory data) =>
    json.encode(data.toJson());

class CovidDeathHistory {
  CovidDeathHistory({
    this.all,
  });

  CountryCovidDeathCases? all;

  factory CovidDeathHistory.fromJson(Map<String, dynamic> json) =>
      CovidDeathHistory(
        all: CountryCovidDeathCases.fromJson(
          json['All'] as Map<String, dynamic>,
        ),
      );

  Map<String, dynamic> toJson() => {
        'All': all?.toJson(),
      };
}

class CountryCovidDeathCases {
  CountryCovidDeathCases({
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
    this.dates,
  });

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
  Map<String, int>? dates;

  factory CountryCovidDeathCases.fromJson(Map<String, dynamic> json) =>
      CountryCovidDeathCases(
        country: json['country'] as String?,
        population: json['population'] as int?,
        sqKmArea: json['sq_km_area'] as int?,
        lifeExpectancy: json['life_expectancy'] as String?,
        elevationInMeters: json['elevation_in_meters'] as String?,
        continent: json['continent'] as String?,
        abbreviation: json['abbreviation'] as String?,
        location: json['location'] as String?,
        iso: json['iso'] as int?,
        capitalCity: json['capital_city'] as String?,
        dates: (json['dates'] as Map<String, int>)
            .map((k, v) => MapEntry<String, int>(k, v)),
      );

  Map<String, dynamic> toJson() => {
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
        'dates': dates?.map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}

//country confirmed cases history

ConfirmedCases confirmedCasesFromJson(String str) =>
    ConfirmedCases.fromJson(json.decode(str) as Map<String, dynamic>);

String confirmedCasesToJson(ConfirmedCases data) => json.encode(data.toJson());

class ConfirmedCases {
  ConfirmedCases({
    this.all,
  });

  CountryConfirmedCases? all;

  factory ConfirmedCases.fromJson(Map<String, dynamic> json) => ConfirmedCases(
        all: CountryConfirmedCases.fromJson(
          json['All'] as Map<String, dynamic>,
        ),
      );

  Map<String, dynamic> toJson() => {
        'All': all?.toJson(),
      };
}

class CountryConfirmedCases {
  CountryConfirmedCases({
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
    this.dates,
  });

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
  Map<String, int>? dates;

  factory CountryConfirmedCases.fromJson(Map<String, dynamic> json) =>
      CountryConfirmedCases(
        country: json['country'] as String?,
        population: json['population'] as int?,
        sqKmArea: json['sq_km_area'] as int?,
        lifeExpectancy: json['life_expectancy'] as String?,
        elevationInMeters: json['elevation_in_meters'] as String?,
        continent: json['continent'] as String?,
        abbreviation: json['abbreviation'] as String?,
        location: json['location'] as String?,
        iso: json['iso'] as int?,
        capitalCity: json['capital_city'] as String?,
        dates: (json['dates'] as Map<String, int>)
            .map((k, v) => MapEntry<String, int>(k, v)),
      );

  Map<String, dynamic> toJson() => {
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
        'dates': dates?.map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}
