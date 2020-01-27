import 'package:az_sqflite/testing/models/city.dart';
import 'package:az_sqflite/testing/models/province.dart';

import '../regional_context.dart';

class RegionalService {
  RegionalContext _dbContext = new RegionalContext();

  Future<List<City>> getCities() {
    return this._dbContext.cities.select().toList();
  }

  Future<int> getCitiesCount() {
    return this._dbContext.cities.select().count();
  }

  Future<bool> deleteCities(String id) async {
    return await this._dbContext.cities.delete(id);
  }

  Future<bool> saveProvince(Province province) async {
    return this._dbContext.usingTransaction(() async {
      String sql = "INSERT INTO province_table VALUES (?, ?)";
      List<dynamic> params = [province.id, province.name];
      int resultInsert = await this._dbContext.rawInsert(sql, params);
      if (resultInsert == 0) {
        return false;
      }

      bool resultCities = await _saveList(province.listOfCities);
      if (!resultCities){
        return false;
      }
      return true;
    });
  }

  Future<bool> _saveList(List<City> cities) async {
    for (int i = 0; i < cities.length; i++) {
      City city = cities[i];

      String sql = "INSERT INTO city_table VALUES (?, ?, ?)";
      List<dynamic> params = [city.id, city.name, city.province.id];
      int resultInsert = await this._dbContext.rawInsert(sql, params);
      if (resultInsert == 0) return false;
    }

    return true;
  }
}