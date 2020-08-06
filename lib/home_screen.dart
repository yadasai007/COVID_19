import 'dart:collection';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'widgets/counter.dart';
import 'widgets/myHeader.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String url = "https://api.covid19api.com/summary";
HashMap<String, int> countryCodeList = HashMap<String, int>();

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCountry = "None";
  var dataStored;
  int totalDeaths = 0;
  int totalRecovered = 0;
  int totalInfected = 0;
  Future<dynamic> getData(String countryCode) async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      String data = response.body;
      dataStored = jsonDecode(data)["Countries"];
      int i = 0;
      for (i = 0; i < 186; i++) {
        if (dataStored[i]['CountryCode'] == countryCode) {
          break;
        } else {
          continue;
        }
      }
      setState(() {
        totalDeaths = dataStored[i]["TotalDeaths"];
        totalInfected = dataStored[i]["TotalConfirmed"];
        totalRecovered = dataStored[i]["TotalRecovered"];
      });
    } else {
      print(response.statusCode);
    }
  }

  Future<dynamic> getDataGlobal() async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      String data = response.body;
      var dataStored = jsonDecode(data)["Global"];
      setState(() {
        totalDeaths = dataStored["TotalDeaths"];
        totalInfected = dataStored["TotalConfirmed"];
        totalRecovered = dataStored["TotalRecovered"];
      });
    } else {
      print(response.statusCode);
    }
  }

  List<DropdownMenuItem<String>> dropDownOptionMethod() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in kCountryList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }
    return dropdownItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            MyHeader(
              image: "assets/icons/Drcorona.svg",
              textTop: "We need to stay",
              textBottom: "indoors to be safe",
              check: true,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Color(0xFFAEAEAE))),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child:
                          SvgPicture.asset("assets/icons/maps-and-flags.svg")),
                  Expanded(
                    flex: 8,
                    child: Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        underline: SizedBox(
                          width: 20,
                        ),
                        icon: SvgPicture.asset("assets/icons/dropdown.svg"),
                        value: selectedCountry,
                        items: dropDownOptionMethod(),
                        onChanged: (value) {
                          setState(() {
                            selectedCountry = value;
                          });
                          if (selectedCountry == "Global") {
                            getDataGlobal();
                          } else if (selectedCountry == "None") {
                            totalInfected = 0;
                            totalRecovered = 0;
                            totalDeaths = 0;
                          } else {
                            getData(kCountryListCodes[selectedCountry]);
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Case Update\n",
                              style: kTitleTextstyle,
                            ),
                            TextSpan(
                              text: "Updated 1 hour ago",
                              style: TextStyle(color: kTextLightColor),
                            )
                          ],
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Text(
                        'See details',
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 4),
                          color: kShadowColor,
                          blurRadius: 30),
                    ],
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Counter(
                          title: "Infected",
                          colour: kInfectedColor,
                          number: totalInfected,
                        ),
                      ),
                      Expanded(
                        child: Counter(
                          title: "Recovered",
                          colour: kRecovercolor,
                          number: totalRecovered,
                        ),
                      ),
                      Expanded(
                        child: Counter(
                          title: "Dead",
                          colour: kDeathColor,
                          number: totalDeaths,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text("Spread of Virus", style: kTitleTextstyle),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Text(
                        'See details',
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  width: double.infinity,
                  height: 178,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 10.0,
                            color: kShadowColor)
                      ]),
                  child: Image.asset(
                    "assets/images/map.png",
                    fit: BoxFit.contain,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
