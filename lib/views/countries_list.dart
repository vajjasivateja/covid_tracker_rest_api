import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shimmer/shimmer.dart';

import '../services/StatesServices.dart';
import 'details_screen.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({Key? key}) : super(key: key);

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextFormField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  hintText: "Search with country name..",
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
                ),
              ),
              Expanded(
                child: FutureBuilder(
                  future: statesServices.fetchCountriesStates(),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                    if (!snapshot.hasData) {
                      return ListView.builder(
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return Shimmer.fromColors(
                              baseColor: Colors.grey.shade200,
                              highlightColor: Colors.grey.shade100,
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: Container(height: 50, width: 50, color: Colors.white),
                                    title: Container(height: 10, width: 80, color: Colors.white),
                                    subtitle: Container(height: 10, width: 80, color: Colors.white),
                                  )
                                ],
                              ));
                        },
                      );
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          String name = snapshot.data![index]["country"];
                          if (searchController.text.isEmpty) {
                            return Column(
                              children: [
                                InkWell(
                                  child: ListTile(
                                    leading: Image.network(
                                      snapshot.data![index]['countryInfo']['flag'],
                                      width: 50,
                                      height: 50,
                                    ),
                                    title: Text(snapshot.data![index]["country"]),
                                    subtitle: Text(snapshot.data![index]["cases"].toString()),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailsScreen(
                                          name: snapshot.data![index]["country"],
                                          image: snapshot.data![index]['countryInfo']['flag'],
                                          cases: snapshot.data![index]["cases"],
                                          todayCases: snapshot.data![index]["todayCases"],
                                          deaths: snapshot.data![index]["deaths"],
                                          todayDeaths: snapshot.data![index]["todayDeaths"],
                                          recovered: snapshot.data![index]["recovered"],
                                          todayRecovered: snapshot.data![index]["todayRecovered"],
                                          active: snapshot.data![index]["active"],
                                          critical: snapshot.data![index]["critical"],
                                        ),
                                      ),
                                    );
                                  },
                                )
                              ],
                            );
                          } else if (name.toLowerCase().contains(searchController.text.toLowerCase())) {
                            return Column(
                              children: [
                                InkWell(
                                  child: ListTile(
                                    leading: Image.network(
                                      snapshot.data![index]['countryInfo']['flag'],
                                      width: 50,
                                      height: 50,
                                    ),
                                    title: Text(snapshot.data![index]["country"]),
                                    subtitle: Text(snapshot.data![index]["cases"].toString()),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailsScreen(
                                          name: snapshot.data![index]["country"],
                                          image: snapshot.data![index]['countryInfo']['flag'],
                                          cases: snapshot.data![index]["cases"],
                                          todayCases: snapshot.data![index]["todayCases"],
                                          deaths: snapshot.data![index]["deaths"],
                                          todayDeaths: snapshot.data![index]["todayDeaths"],
                                          recovered: snapshot.data![index]["recovered"],
                                          todayRecovered: snapshot.data![index]["todayRecovered"],
                                          active: snapshot.data![index]["active"],
                                          critical: snapshot.data![index]["critical"],
                                        ),
                                      ),
                                    );
                                  },
                                )
                              ],
                            );
                          } else {
                            return Container();
                          }
                        },
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
