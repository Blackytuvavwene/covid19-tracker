import 'dart:convert';

import 'package:covid_19_tracker/src/keys/scaffold_key.dart';
import 'package:covid_19_tracker/src/models/country_model.dart';
import 'package:covid_19_tracker/src/models/global_cases.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';

String url = 'https://covid-api.mmediagroup.fr/v1';

String jsonD = 'assets/countries.json';

Future<String> getJson() {
  return rootBundle.loadString('assets/countries.json');
}
//load from json file

class Covid19ApiService {
  //get covid-19 cases worldwide
  Covid19ApiService._();
  static final instance = Covid19ApiService._();
  static Future<GlobalCases> getGlobalCases() async {
    final Response response = await get(Uri.parse('$url/cases?country=Global'));
    if (response.statusCode != 200) {
      //display error message on fetch data failed
      snackKey.currentState?.showSnackBar(
        SnackBar(
          content: Text('Error retrieving data ${response.statusCode}'),
        ),
      );
    }
    final dataMap = jsonDecode(response.body) as Map<String, dynamic>;
    return GlobalCases.fromJson(dataMap);
  }

  //get covid-19 cases
  static Future<T> getCovidCases<T>({
    required String country,
    required T Function(String json) builder,
  }) async {
    final Response response =
        await get(Uri.parse('$url/cases?country=$country'));
    if (response.statusCode != 200) {
      //display error message on fetch data failed
      snackKey.currentState?.showSnackBar(
        SnackBar(
          content: Text('Error retrieving data ${response.statusCode}'),
        ),
      );
    }

    return builder(response.body);
  }

  //get covid-19 cases history
  static Future<T> getCovidCasesHistory<T>({
    required String country,
    required String history,
    required T Function(String json) builder,
  }) async {
    final Response response = await get(
      Uri.parse('$url/history?country=$country&status=$history'),
    );
    if (response.statusCode != 200) {
      //display error message on fetch data failed
      snackKey.currentState?.showSnackBar(
        SnackBar(
          content: Text('Error retrieving data ${response.statusCode}'),
        ),
      );
    }

    return builder(response.body);
  }

  //get vaccination details
  static Future<T> getVaccinationDetails<T>({
    required String country,
    required T Function(String json) builder,
  }) async {
    final Response response = await get(
      Uri.parse('$url/vaccines?country=$country'),
    );
    if (response.statusCode != 200) {
      //display error message on fetch data failed
      snackKey.currentState?.showSnackBar(
        SnackBar(
          content: Text('Error retrieving data ${response.statusCode}'),
        ),
      );
    }

    return builder(response.body);
  }
}
