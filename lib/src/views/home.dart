import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:covid_19_tracker/src/constants/colors.dart';
import 'package:covid_19_tracker/src/constants/constants.dart';
import 'package:covid_19_tracker/src/models/countries.dart';
import 'package:covid_19_tracker/src/models/global_cases.dart';
import 'package:covid_19_tracker/src/providers/covid_data.dart';
import 'package:covid_19_tracker/src/views/widgets/country_cases.dart';
import 'package:covid_19_tracker/src/views/widgets/global_cases.dart';
import 'package:covid_19_tracker/src/views/widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:layout/layout.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
//initialize provider activity
  @override
  void initState() {
    super.initState();
    Provider.of<CovidData>(context, listen: false).getCountriesList();
    Provider.of<CovidData>(context, listen: false).getCovidCases();
  }

  //dropdown button
  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    final List<DropdownMenuItem<String>> items = [];
    for (final Countries country in Provider.of<CovidData>(context).countries) {
      items.add(
        DropdownMenuItem(
          value: country.name,
          child: Text('${country.name}'),
        ),
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CovidData>(
      builder: (context, data, child) {
        return Responsive(
          mobile: _MobileHome(data: data),
          web: _WebHome(data: data),
          tablet: _MobileHome(data: data),
        );
      },
    );
  }
}

//mobile view for home page
class _MobileHome extends HookWidget {
  const _MobileHome({
    Key? key,
    required this.data,
  }) : super(key: key);
  final CovidData data;

  @override
  Widget build(BuildContext context) {
    //animation
    final _fadeController = useAnimationController(
      animationBehavior: AnimationBehavior.preserve,
      duration: const Duration(
        seconds: 10,
      ),
    );

    final _fadeTween = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(_fadeController);
    useEffect(
      () {
        _fadeController.forward();
      },
      [_fadeController],
    );
    final _fade = useAnimation(_fadeTween);

    //dropdown button
    List<DropdownMenuItem<String>> getDropDownMenuItems() {
      final List<DropdownMenuItem<String>> items = [];
      for (final Countries country
          in Provider.of<CovidData>(context).countries) {
        items.add(
          country.name == data.type
              ? DropdownMenuItem(
                  value: country.name,
                  child: Container(
                    height: 4.h,
                    width: 100.w,
                    color: Colors.grey,
                    child: AutoSizeText('${country.name}'),
                  ),
                )
              : DropdownMenuItem(
                  value: country.name,
                  child: AutoSizeText('${country.name}'),
                ),
        );
      }
      return items;
    }

    return Consumer<CovidData>(
      builder: (context, data, child) {
        return data.isLoading == true
            ? const Scaffold(
                backgroundColor: AppColors.appDarkNavy,
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Scaffold(
                appBar: context.breakpoint >= LayoutBreakpoint.sm
                    ? PreferredSize(
                        preferredSize: Size(
                          100.w,
                          10.h,
                        ),
                        child: Container(
                          child: Center(
                            child: AutoSizeText(
                              'COVID-19 TRACKER',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.appLightNavy,
                              ),
                            ),
                          ),
                        ),
                      )
                    : AppBar(
                        backgroundColor: AppColors.appDarkNavy,
                        elevation: 0,
                        title: AutoSizeText(
                          'COVID-19 Tracker M',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                backgroundColor: AppColors.appDarkNavy,
                body: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(
                            1.5.w,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: AutoSizeText(
                                  '${data.type} cases',
                                  style: TextStyle(
                                    color: AppColors.appLightNavy,
                                    fontWeight:
                                        context.breakpoint > LayoutBreakpoint.xs
                                            ? FontWeight.w900
                                            : FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: context.breakpoint > LayoutBreakpoint.xs
                                    ? 30.w
                                    : 50.w,
                                child: DropdownButtonFormField(
                                  enableFeedback: true,
                                  decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey,
                                    isDense: true,
                                  ),
                                  isExpanded: true,
                                  hint: const AutoSizeText('Select Country'),
                                  items: getDropDownMenuItems(),
                                  onChanged: (value) {
                                    data.changeType(value.toString());
                                    data.getCovidCases();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (data.type == 'Global')
                          SizedBox(
                            height: 100.h,
                            child: GlobalCasesWidget(
                              data: data,
                              animation: _fadeTween,
                              globalCases: data.globalCovidCases!,
                            ),
                          )
                        else
                          CountryCases(
                            data: data,
                            country: data.country,
                            animation: _fadeTween,
                          ),
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }
}

//web view for home page
class _WebHome extends HookWidget {
  const _WebHome({
    Key? key,
    required this.data,
  }) : super(key: key);
  final CovidData data;

  @override
  Widget build(BuildContext context) {
    //animation
    final _fadeController = useAnimationController(
      vsync: useSingleTickerProvider(),
      animationBehavior: AnimationBehavior.preserve,
      duration: const Duration(
        seconds: 10,
      ),
    );

    final _fadeTween = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(_fadeController);
    useEffect(
      () {
        _fadeController.forward();
      },
      [_fadeController],
    );
    final _fade = useAnimation(_fadeTween);

    //dropdown button
    List<DropdownMenuItem<String>> getDropDownMenuItems() {
      final List<DropdownMenuItem<String>> items = [];
      for (final Countries country
          in Provider.of<CovidData>(context).countries) {
        items.add(
          country.name == data.type
              ? DropdownMenuItem(
                  value: country.name,
                  child: Container(
                    height: 4.h,
                    width: 100.w,
                    color: Colors.grey,
                    child: AutoSizeText('${country.name}'),
                  ),
                )
              : DropdownMenuItem(
                  value: country.name,
                  child: AutoSizeText('${country.name}'),
                ),
        );
      }
      return items;
    }

    return Consumer<CovidData>(
      builder: (context, data, child) {
        return data.isLoading == true
            ? const Scaffold(
                backgroundColor: AppColors.appDarkNavy,
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Scaffold(
                appBar: PreferredSize(
                  preferredSize: Size(
                    100.w,
                    10.h,
                  ),
                  child: Container(
                    child: Center(
                      child: SizedBox(
                        height: 9.h,
                        child: AutoSizeText(
                          'COVID-19 TRACKER',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.appLightNavy,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                backgroundColor: AppColors.appDarkNavy,
                body: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 1.5.h,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: AutoSizeText(
                                  '${data.type} cases',
                                  style: const TextStyle(
                                    color: AppColors.appLightNavy,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 35.w,
                                child: DropdownButtonFormField(
                                  enableFeedback: true,
                                  decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey,
                                    isDense: true,
                                  ),
                                  isExpanded: true,
                                  hint: const AutoSizeText('Select Country'),
                                  items: getDropDownMenuItems(),
                                  onChanged: (value) {
                                    data.changeType(value.toString());
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (data.type == 'Global')
                          SizedBox(
                            height: 100.h,
                            child: GlobalCasesWidget(
                              data: data,
                              animation: _fadeTween,
                              globalCases: data.globalCovidCases!,
                            ),
                          )
                        else
                          CountryCases(
                            data: data,
                            country: data.country!,
                            animation: _fadeTween,
                          ),
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }
}
