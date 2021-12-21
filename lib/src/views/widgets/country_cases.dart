//widget for country cases
import 'package:covid_19_tracker/src/models/country_model.dart';
import 'package:covid_19_tracker/src/providers/covid_data.dart';
import 'package:covid_19_tracker/src/views/widgets/responsive.dart';
import 'package:flutter/material.dart';

class CountryCases extends StatelessWidget {
  const CountryCases({
    Key? key,
    required this.data,
    required this.country,
    required this.animation,
  }) : super(key: key);
  final CovidData data;
  final Country? country;
  final Animation animation;

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: _MobileCountryCases(
        data: data,
        country: country,
        animation: animation,
      ),
      web: _WebCountryCases(
        data: data,
        country: country,
        animation: animation,
      ),
      tablet: _MobileCountryCases(
        data: data,
        country: country,
        animation: animation,
      ),
    );
  }
}

//web view for country cases
class _WebCountryCases extends StatelessWidget {
  const _WebCountryCases({
    Key? key,
    required this.data,
    required this.country,
    required this.animation,
  }) : super(key: key);
  final CovidData data;
  final Country? country;
  final Animation animation;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// mobile view for country cases
class _MobileCountryCases extends StatelessWidget {
  const _MobileCountryCases({
    Key? key,
    required this.data,
    required this.country,
    required this.animation,
  }) : super(key: key);
  final CovidData data;
  final Country? country;
  final Animation animation;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('${country?.countryData?.country}'),
      ),
    );
  }
}
