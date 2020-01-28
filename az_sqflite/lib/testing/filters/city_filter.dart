import 'package:az_sqflite/src/filters/filter_base.dart';
import 'package:az_sqflite/testing/models/city.dart';

class CityFilter extends FilterBase<City> {
  CityFilter(City city) : super(modelInstance: city);

  final String id = "field_id";
  final String name = "field_name";
}