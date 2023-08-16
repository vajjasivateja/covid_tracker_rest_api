import 'package:covid_tracker_rest_api/model/ResponseWorldStates.dart';
import 'package:covid_tracker_rest_api/services/StatesServices.dart';
import 'package:covid_tracker_rest_api/views/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WorldScreens extends StatefulWidget {
  const WorldScreens({Key? key}) : super(key: key);

  @override
  State<WorldScreens> createState() => _WorldScreensState();
}

class _WorldScreensState extends State<WorldScreens> with TickerProviderStateMixin {
  late final AnimationController controller = AnimationController(duration: const Duration(seconds: 3), vsync: this)..repeat();

  final colorsList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return SafeArea(
        child: Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            FutureBuilder(
              future: statesServices.fetchWorldStates(),
              builder: (context, AsyncSnapshot<ResponseWorldStates> snapshot) {
                if (!snapshot.hasData) {
                  return Expanded(
                    flex: 1,
                    child: SpinKitFadingCircle(
                      color: Colors.white,
                      size: 50,
                      controller: controller,
                    ),
                  );
                } else {
                  return Column(
                    children: [
                      PieChart(
                        dataMap: {
                          "Total": double.parse(snapshot.data!.cases.toString()),
                          "Recovered": double.parse(snapshot.data!.recovered.toString()),
                          "Deaths": double.parse(snapshot.data!.deaths.toString()),
                        },
                        chartValuesOptions: const ChartValuesOptions(showChartValuesInPercentage: true),
                        animationDuration: const Duration(milliseconds: 1200),
                        chartType: ChartType.ring,
                        colorList: colorsList,
                        chartRadius: MediaQuery.of(context).size.width / 3.2,
                        legendOptions: const LegendOptions(legendPosition: LegendPosition.left),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
                        child: Card(
                          child: Column(
                            children: [
                              ReusableRow(title: "Total", value: snapshot.data!.cases.toString()),
                              ReusableRow(title: "Deaths", value: snapshot.data!.deaths.toString()),
                              ReusableRow(title: "Recovered", value: snapshot.data!.recovered.toString()),
                              ReusableRow(title: "Active", value: snapshot.data!.active.toString()),
                              ReusableRow(title: "Critical", value: snapshot.data!.critical.toString()),
                              ReusableRow(title: "Today Cases", value: snapshot.data!.todayCases.toString()),
                              ReusableRow(title: "Today Deaths", value: snapshot.data!.todayDeaths.toString()),
                              ReusableRow(title: "Today Recovered", value: snapshot.data!.todayRecovered.toString()),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 50),
                      GestureDetector(
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text("Track Countries"),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const CountriesList()));
                        },
                      )
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    ));
  }
}

class ReusableRow extends StatelessWidget {
  ReusableRow({Key? key, required this.title, required this.value}) : super(key: key);
  String title, value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          Divider()
        ],
      ),
    );
  }
}
