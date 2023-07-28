import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'postModelCountry.dart';
import 'postModelState.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<PostModelCountry> countries = [];
  List<String> states = [];

  String selectedCountry = '';
  String? selectedState;
  String countryId = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCountries();
  }

  void fetchCountries() async {
    try {
      var response = await http.get(Uri.parse(
          "http://192.168.88.10:30513/otonomus/common/api/v1/countries?page=0&size=300"));
      var decodedResponse = jsonDecode(response.body);
      var result = decodedResponse['data'];

      if (result != null && result is List) {
        final finalResponse =
            result.map((map) => PostModelCountry.fromJson(map)).toList();

        for (int i = 0; i < finalResponse.length; i++) {
          countries.add(finalResponse[i]);
        }
        setState(() {});
      }
    } catch (e) {
      print("Error fetching countries: $e");
    }
  }

  void fetchStatesByCountryId(String id) async {
    try {
      var response = await http.get(Uri.parse(
          "http://192.168.88.10:30513/otonomus/common/api/v1/country/$id/states"));
      var decodedResponse = jsonDecode(response.body);
      var result = decodedResponse['data'];

      if (result != null && result is List) {
        final finalResponse =
            result.map((map) => PostModelState.fromJson(map)).toList();
        setState(() {
          states.clear();
          for (int i = 0; i < finalResponse.length; i++) {
            states.add(finalResponse[i].stateName);
          }
        });
        print(states.length);
      }
    } catch (e) {
      print("Error fetching states: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Country and State'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              width: double.infinity,
              child: DropdownButton<String>(
                value: selectedCountry == "" ? null : selectedCountry,
                hint: Text('Select a country'),
                onChanged: (newValue) {
                  setState(() {
                    selectedState = '';
                    selectedCountry = newValue!;
                    states.clear();
                    countryId = countries
                        .firstWhere(
                            (country) => country.countryName == selectedCountry)
                        .idCountry;
                    fetchStatesByCountryId(countryId);
                  });
                },
                items: countries.map((country) {
                  return DropdownMenuItem<String>(
                    value: country.countryName,
                    child: Text(country.countryName),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              width: double.infinity,
              child: DropdownButton<String>(
                value: selectedState == "" ? null : selectedState,
                hint: Text('Select state'),
                onChanged: (newValue) {
                  setState(() {
                    selectedState = newValue!;
                  });
                },
                items: states.map((String state) {
                  return DropdownMenuItem<String>(
                    value: state,
                    child: Text(state),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
