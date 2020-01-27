import 'package:az_sqflite/testing/regional_context.dart';
import 'package:flutter/material.dart';

import 'models/city.dart';
import 'models/province.dart';
import 'services/regional_service.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  RegionalService rs = new RegionalService();
  List<City> listMap = new List<City>();
  int count = 0;

  void reload() async {
    rs.getCities().then((val) => this.setState(()=>this.listMap = val));
    rs.getCitiesCount().then((val) { 
      this.setState(() { this.count = val; });
     });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contoh SQFLite"),
      ),
      body: ListView.builder(
        itemBuilder: (context, row) {
          return Container(
            child: Column(
              children: <Widget>[
                Text(listMap[row].id),
                Text(listMap[row].name),
                MaterialButton(
                  child: Text("REMOVE"),
                  onPressed: () async {
                    this.rs.deleteCities(listMap[row].id).then((result) {
                      this.reload();
                    });
                  },
                )
              ],
            ),
          );
        },
        itemCount: this.listMap.length,
      ),
      persistentFooterButtons: <Widget>[
        MaterialButton(
          child: Text("Reload (${count.toString()})"),
          onPressed: () {
            reload();
          },
        ),
        MaterialButton(
          child: Text("Add"),
          onPressed: () async {
            Province province = new Province();
            province.id = "province_k";
            province.name = "province_d";
            province.listOfCities = new List<City>();
            for (int i = 6; i < 10; i++) {
              City city = new City();
              city.id = "city_${i}";
              city.name = "city_${i}";
              city.province = province;
              province.listOfCities.add(city);
            }
            rs.saveProvince(province).catchError((onError) { print(onError); });
          },
        ),
      ],
    );
  }
}

