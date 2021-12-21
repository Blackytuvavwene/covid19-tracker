import 'package:auto_size_text/auto_size_text.dart';
import 'package:covid_19_tracker/src/models/global_cases.dart';
import 'package:covid_19_tracker/src/providers/covid_data.dart';
import 'package:covid_19_tracker/src/views/widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sizer/sizer.dart';

class GlobalCasesWidget extends StatelessWidget {
  const GlobalCasesWidget({
    Key? key,
    required this.animation,
    required this.data,
    required this.globalCases,
  }) : super(key: key);
  final Animation animation;
  final CovidData data;
  final GlobalCases globalCases;

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: _MobileGlobalCases(
        animation: animation,
        data: data,
        globalCases: globalCases,
      ),
      web: _GlobalWebCases(
        animation: animation,
        data: data,
        globalCases: globalCases,
      ),
      tablet: _MobileGlobalCases(
        animation: animation,
        data: data,
        globalCases: globalCases,
      ),
    );
  }
}

class _GlobalWebCases extends StatelessWidget {
  const _GlobalWebCases({
    Key? key,
    required this.animation,
    required this.data,
    required this.globalCases,
  }) : super(key: key);
  final Animation animation;
  final CovidData data;
  final GlobalCases globalCases;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 10.h,
      ),
      child: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 5.w,
        crossAxisSpacing: 5.w,
        childAspectRatio: 3,
        children: [
          _GlobalCasesCard(
            animation: animation,
            data: data,
            globalCases: globalCases,
            title: 'Total Cases',
            color: Colors.red,
          ),
          _GlobalCasesCard(
            animation: animation,
            data: data,
            globalCases: globalCases,
            title: 'Total Deaths',
            color: Colors.grey,
          ),
          _GlobalCasesCard(
            animation: animation,
            data: data,
            globalCases: globalCases,
            title: 'Total Population',
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}

//widget for global cases mobile view
class _MobileGlobalCases extends StatelessWidget {
  const _MobileGlobalCases({
    Key? key,
    required this.animation,
    required this.data,
    required this.globalCases,
  }) : super(key: key);
  final Animation animation;
  final CovidData data;
  final GlobalCases globalCases;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 10.h,
      ),
      child: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 5.w,
        crossAxisSpacing: 5.w,
        children: [
          _GlobalCasesCard(
            animation: animation,
            data: data,
            globalCases: globalCases,
            title: 'Total Cases',
            color: Colors.red,
          ),
          _GlobalCasesCard(
            animation: animation,
            data: data,
            globalCases: globalCases,
            title: 'Total Deaths',
            color: Colors.grey,
          ),
          _GlobalCasesCard(
            animation: animation,
            data: data,
            globalCases: globalCases,
            title: 'Total Population',
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}

class _GlobalCasesCard extends HookWidget {
  const _GlobalCasesCard({
    Key? key,
    required this.animation,
    required this.data,
    required this.globalCases,
    required this.title,
    required this.color,
  }) : super(key: key);
  final Animation animation;
  final CovidData data;
  final GlobalCases globalCases;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final _transitionController = useAnimationController(
      duration: const Duration(
        seconds: 3,
      ),
    );
    final _transition = Tween<Offset>(
      begin: const Offset(0, 1),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _transitionController,
        curve: Curves.ease,
      ),
    );
    final _transition2 = Tween<Offset>(
      begin: const Offset(-1, -1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _transitionController,
        curve: Curves.easeIn,
      ),
    );
    int? _data() {
      if (title == 'Total Cases') {
        return globalCases.all?.confirmed;
      } else if (title == 'Total Deaths') {
        return globalCases.all?.deaths;
      } else if (title == 'Total Population') {
        return globalCases.all?.population;
      }
    }

    useEffect(
      () {
        _transitionController.forward();
      },
      [],
    );

    return FadeTransition(
      opacity: Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: animation as Animation<double>,
          curve: Curves.ease,
        ),
      ),
      child: Card(
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: AutoSizeText(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SlideTransition(
                position: _transition,
                child: AutoSizeText(
                  _data().toString(),
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
