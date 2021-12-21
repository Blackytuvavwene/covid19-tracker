import 'dart:async';

import 'package:covid_19_tracker/src/models/countries.dart';
import 'package:covid_19_tracker/src/models/country_model.dart';
import 'package:covid_19_tracker/src/models/global_cases.dart';
import 'package:covid_19_tracker/src/services/covid_19_api_service.dart';
import 'package:flutter/foundation.dart';

class CovidData with ChangeNotifier {
  //private variables
  //private variable for global cases
  GlobalCases? _global;
  //private variable for country cases
  Country? _countryCases;
  //private variable for country vaccination data
  VaccineCountryData? _vaccineCountryData;
  //private variable for country death cases caused by covid 19
  CovidDeathHistory? _deathCountryCases;
  //private variable for country confirmed cases caused by covid 19
  ConfirmedCases? _confirmedCountryCases;
  //private variable for list of countries
  final List<Countries> _countries = [];
  //instance of the api service
  final apiService = Covid19ApiService.instance;

//global variables
//isloading is used to show the loading process
  bool isLoading = false;
  //type variable is used to get the type of data that is being loaded
  String type = 'Global';

  //getters
  //getter for global cases
  GlobalCases? get globalCovidCases => _global;
  //getter for list of countries
  List<Countries> get countries => _countries;
  //getter for country cases
  Country? get country => _countryCases;
  //getter for country vaccination data
  VaccineCountryData? get vaccineCountryData => _vaccineCountryData;
  //getter for country death cases caused by covid 19
  CovidDeathHistory? get deathCountryCases => _deathCountryCases;
  //getter for country confirmed cases caused by covid 19
  ConfirmedCases? get confirmedCountryCases => _confirmedCountryCases;

//function to change type variable
  String changeType(String data) {
    type = data;
    notifyListeners();
    return type;
  }

//function to get data from api
  Future<void> getCovidCases() async {
    isLoading = true;
    if (type == 'Global') {
      //if type is global get covid global cases
      await _getGlobalCases(type);
    } else {
      //if type is country get covid country cases
      await _getCountryCases(type);
    }

    isLoading = false;
    notifyListeners();
  }

//load country list from json file
  Future<List<Countries>> getCountriesList() async {
    final countries = await getJson();
    final countriesList = countriesFromJson(countries);
    _countries.addAll(countriesList);
    notifyListeners();
    return _countries;
  }

  //get country all covid data
  Future<void> _getCountryCases(String country) async {
    await _getCountryCovidCasesData(country);
    await _getCountryDeathHistory(country);
    await _getCountryConfirmedHistory(country);
    await _getCountryVaccineData(country);
    notifyListeners();
  }

//get country summarised data
  Future<Country> _getCountryCovidCasesData(String search) async {
    return _countryCases = await Covid19ApiService.getCovidCases<Country>(
      country: search,
      builder: (json) => countryDataFromJson(json),
    );
  }

  //get death history for country
  Future<CovidDeathHistory> _getCountryDeathHistory(String search) async {
    return _deathCountryCases =
        await Covid19ApiService.getCovidCasesHistory<CovidDeathHistory>(
      country: search,
      history: 'deaths',
      builder: (json) => covidDeathHistoryFromJson(json),
    );
  }

  //get country vaccination data
  Future<VaccineCountryData> _getCountryVaccineData(String search) async {
    return _vaccineCountryData =
        await Covid19ApiService.getCovidCasesHistory<VaccineCountryData>(
      country: search,
      history: 'vaccine',
      builder: (json) => vaccineCountryDataFromJson(json),
    );
  }

  //get confirmed history for country
  Future<ConfirmedCases> _getCountryConfirmedHistory(String search) async {
    return _confirmedCountryCases =
        await Covid19ApiService.getCovidCasesHistory<ConfirmedCases>(
      country: search,
      history: 'confirmed',
      builder: (json) => confirmedCasesFromJson(json),
    );
  }

  Future<GlobalCases> _getGlobalCases(String data) async {
    return _global = await Covid19ApiService.getCovidCases<GlobalCases>(
      country: data,
      builder: (json) => globalCasesFromJson(json),
    );
  }
}
