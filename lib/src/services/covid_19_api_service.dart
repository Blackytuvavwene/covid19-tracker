import 'dart:convert';

import 'package:covid_19_tracker/src/keys/scaffold_key.dart';
import 'package:covid_19_tracker/src/models/country_model.dart';
import 'package:covid_19_tracker/src/models/global_cases.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

var url = 'https://covid-api.mmediagroup.fr/v1/cases';

class Covid19ApiService {
  //get covid-19 cases worldwide
  Future<GlobalCases> getGlobalCases() async {
    final Response response = await get(Uri.parse('$url?country=Global'));
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
}
