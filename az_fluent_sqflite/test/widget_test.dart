// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:az_fluent_sqflite/test/models/province.dart';
import 'package:az_fluent_sqflite/test/region_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:az_fluent_sqflite/src/az_fluent_sqflite.dart';

void main() {
  testWidgets('Test Equals', (WidgetTester tester) async {
    String id = "field_id";
    TreeFilter filter = id.fieldEquals(2);
    SQLFilter sqlResult = filter.toSQL();
    expect("field_id = ?", sqlResult.sql);
    expect(1, sqlResult.parameters.length);
    expect(2, sqlResult.parameters[0]);
  });

  testWidgets('Test Like', (WidgetTester tester) async {
    String id = "field_id";
    TreeFilter filter = id.fieldLike(2);
    SQLFilter sqlResult = filter.toSQL();
    expect("field_id LIKE ?", sqlResult.sql);
    expect(1, sqlResult.parameters.length);
    expect('%2%', sqlResult.parameters[0]);
  });
  
  testWidgets('test sqlite', (WidgetTester tester) async {
    RegionContext regionContext = new RegionContext();
    List<Province> listOfProvince = await regionContext.provinces.select().toList();
  });
}
