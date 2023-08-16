import 'dart:convert';

import 'package:covid_tracker_rest_api/utilities/app_urls.dart';
import 'package:http/http.dart' as http;

import '../model/ResponseWorldStates.dart';

class StatesServices {
  Future<ResponseWorldStates> fetchWorldStates() async {
    final response = await http.get(Uri.parse(AppURLs.worldStateApi));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      return ResponseWorldStates.fromJson(data);
    } else {
      throw Exception("Error");
    }
  }

  Future<List<dynamic>> fetchCountriesStates() async {
    var data;
    final response = await http.get(Uri.parse(AppURLs.countriesListApi));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      print(data);
      return data;
    } else {
      throw Exception("Error");
    }
  }
}
