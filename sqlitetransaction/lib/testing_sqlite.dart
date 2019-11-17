import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:sqlitetransaction/sqflite_custom/sqflite_custom.dart';
import 'package:sqlitetransaction/testing/daos/province_dao.dart';
import 'package:sqlitetransaction/testing/data_access.dart';
import 'package:sqlitetransaction/testing/models/province.dart';

class TestingSQLite extends StatefulWidget {
  @override
  _TestingSQLiteState createState() => _TestingSQLiteState();
}

class _TestingSQLiteState extends State<TestingSQLite> {
  String dbName = "sample.db";
  int version = 1;
  onPressedTest() async {
    Database database = await DataAccess.getAppDB();
    SQFLiteTransaction.beginTrans(db: database, transactionScope: (scope, db) async {
      ProvinceDAO provinceDao = new ProvinceDAO(db);
      Province prov = new Province();
      prov.name = "Jawa Barat";
      int result = await provinceDao.insert(prov);
      List<Province> listOfProvince = await provinceDao.getList();
      int counter = listOfProvince == null ? 0 : listOfProvince.length;
      int x = 0; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: RaisedButton(child: Text("TEST"), onPressed: this.onPressedTest,),
      ), 
    );
  }
}