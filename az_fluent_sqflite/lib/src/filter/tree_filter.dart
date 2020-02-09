import 'package:az_fluent_sqflite/src/filter/filter_composition.dart';
import 'package:az_fluent_sqflite/src/filter/filter_operation.dart';
import 'package:az_fluent_sqflite/src/filter/sql_filter.dart';

class TreeFilter {
  String fieldName;
  dynamic value;
  List<dynamic> values;
  FilterOperation operation;

  TreeFilter left;
  TreeFilter right;
  FilterComposition composition;

  SQLFilter toSQL() {
    SQLFilter sqlFilter = new SQLFilter();
    if (operation != null) {
      if (operation == FilterOperation.Between) {
        sqlFilter.sql = "${this.fieldName} BETWEEN ? AND ?";
        sqlFilter.parameters.addAll(this.values);
      }
      else if (operation == FilterOperation.Equals) {
        sqlFilter.sql = "${this.fieldName} = ?";
        sqlFilter.parameters.add(this.value);
      }
      else if (operation == FilterOperation.NotEquals) {
        sqlFilter.sql = "${this.fieldName} <> ?";
        sqlFilter.parameters.add(this.value);
      }
      else if (operation == FilterOperation.In) {
        List<String> params = this.values.map((val) => "?").toList();
        sqlFilter.sql = "${this.fieldName} IN (${params.join(", ")})";
        sqlFilter.parameters.addAll(this.values);
      }
      else if (operation == FilterOperation.Like) {
        sqlFilter.sql = "${this.fieldName} LIKE ?";
        sqlFilter.parameters.add("%${value}%");
      }
      else {
        throw new Exception("Operation is not valid.");
      }
    } 
    else if (composition != null) {
      if (composition == FilterComposition.And) {
        SQLFilter leftSQL = this.left.toSQL();
        SQLFilter rightSQL = this.right.toSQL();
        sqlFilter.sql = "((${leftSQL.sql}) AND (${rightSQL.sql}))";
        sqlFilter.parameters.addAll(leftSQL.parameters);
        sqlFilter.parameters.addAll(rightSQL.parameters);
      } else if (composition == FilterComposition.Or) {
        SQLFilter leftSQL = this.left.toSQL();
        SQLFilter rightSQL = this.right.toSQL();
        sqlFilter.sql = "((${leftSQL.sql}) OR (${rightSQL.sql}))";
        sqlFilter.parameters.addAll(leftSQL.parameters);
        sqlFilter.parameters.addAll(rightSQL.parameters);
      }
      else {
        throw new Exception("Operation is not valid.");  
      }
    } 
    else {
      throw new Exception("Operation is not valid.");
    }
    return sqlFilter;
  }
  

  TreeFilter.equalsFilter(this.fieldName, this.value){
    this.operation = FilterOperation.Equals;
  }
  TreeFilter.notEqualsFilter(this.fieldName, this.value){
    this.operation = FilterOperation.NotEquals;
  }
  TreeFilter.likeFilter(this.fieldName, this.value) {
    this.operation = FilterOperation.Like;
  }
  TreeFilter.inFilter(this.fieldName, this.values) {
    this.operation = FilterOperation.In;
  }
  TreeFilter.betweenFilter(this.fieldName, dynamic from, dynamic to) {
    List<dynamic> list = [from, to];
    this.values = list;
    this.operation = FilterOperation.Between;
  }

  TreeFilter.or(this.left, this.right) {
    this.composition = FilterComposition.Or;
  }
  TreeFilter.and(this.left, this.right) {
    this.composition = FilterComposition.And;
  }
}