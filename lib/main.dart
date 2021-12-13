import 'package:covid_19_tracker/src/keys/scaffold_key.dart';
import 'package:covid_19_tracker/src/models/global_cases.dart';
import 'package:covid_19_tracker/src/providers/covid_data.dart';
import 'package:covid_19_tracker/src/views/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<CovidData>(
          create: (_) => CovidData(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final covidData = Provider.of<CovidData>(
      context,
      listen: false,
    );
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          scaffoldMessengerKey: snackKey,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const Home(),
        );
      },
    );
  }
}
