import 'package:az_fluent_sqflite/src/base/export.dart';
import 'package:az_fluent_sqflite/test/models/province.dart';

class ProvinceFilter extends FilterBase<Province> {
  ProvinceFilter(Province instance) : super(instance);
  final String id = "field_id";
  final String name = "field_name";
}