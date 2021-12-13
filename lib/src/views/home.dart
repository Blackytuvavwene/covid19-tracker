import 'package:covid_19_tracker/src/providers/covid_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

    Provider.of<CovidData>(context, listen: false).getGlobalCovid();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CovidData>(
      builder: (context, data, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(20),
                sliver: SliverSafeArea(
                  sliver: SliverGrid.count(
                    crossAxisCount: 2,
                    children: [
                      Card(
                        color: Colors.yellow,
                        child: Column(
                          children: [
                            Text('${data.globalCovidCases?.all?.population}')
                          ],
                        ),
                      ),
                      Card(
                        color: Colors.red,
                        child: Column(
                          children: [
                            Text('${data.globalCovidCases?.all?.confirmed}')
                          ],
                        ),
                      ),
                      Card(
                        color: Colors.blue,
                        child: Column(
                          children: [
                            Text('${data.globalCovidCases?.all?.recovered}')
                          ],
                        ),
                      ),
                      Card(
                        color: Colors.green,
                        child: Column(
                          children: [
                            Text('${data.globalCovidCases?.all?.deaths}')
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
