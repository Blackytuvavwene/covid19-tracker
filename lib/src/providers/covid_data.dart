import 'package:covid_19_tracker/src/models/global_cases.dart';
import 'package:covid_19_tracker/src/services/covid_19_api_service.dart';
import 'package:flutter/foundation.dart';

class CovidData with ChangeNotifier {
  GlobalCases? _global;

  GlobalCases? get globalCovidCases => _global;

  Future<void> getGlobalCovid() async {
    _global = await Covid19ApiService().getGlobalCases();
    notifyListeners();
  }
}
