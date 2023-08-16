import 'package:covid_tracker_rest_api/views/worls_states.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  DetailsScreen({
    super.key,
    required this.name,
    required this.image,
    required this.cases,
    required this.todayCases,
    required this.deaths,
    required this.todayDeaths,
    required this.recovered,
    required this.todayRecovered,
    required this.active,
    required this.critical,
  });

  String name, image;
  int cases, todayCases, deaths, todayDeaths, recovered, todayRecovered, active, critical;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text(widget.name), centerTitle: true),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.070),
                  child: Card(
                    child: Column(
                      children: [
                        ReusableRow(title: "Cases", value: widget.cases.toString()),
                        ReusableRow(title: "Deaths", value: widget.deaths.toString()),
                        ReusableRow(title: "Recovered", value: widget.recovered.toString()),
                        ReusableRow(title: "Active", value: widget.active.toString()),
                        ReusableRow(title: "Critical", value: widget.critical.toString()),
                        ReusableRow(title: "Today Cases", value: widget.todayCases.toString()),
                        ReusableRow(title: "Today Deaths", value: widget.todayDeaths.toString()),
                        ReusableRow(title: "Today Recovered", value: widget.todayRecovered.toString()),
                      ],
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(widget.image),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
