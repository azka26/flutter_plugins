import 'package:az_sqflite/src/field_type.dart';
import 'package:az_sqflite/src/filters/filter_composition.dart';
import 'package:az_sqflite/src/filters/filter_operation.dart';

class TreeFilter {
  String fieldName;
  FieldType fieldType;
  dynamic value;
  List<dynamic> values;
  FilterOperation operation;
  FilterComposition composition;

  TreeFilter leftFilter;
  TreeFilter rightFilter;

  TreeFilter.equalsFilter(this.fieldName, this.value) {
    this.operation = FilterOperation.Equals;
  }
  TreeFilter.likeFilter(this.fieldName, this.value) {
    this.operation = FilterOperation.Like;
  }
  TreeFilter.inFilter(this.fieldName, this.values) {
    this.operation = FilterOperation.In;
  }
  TreeFilter.and(TreeFilter left, TreeFilter right) {
    leftFilter = left;
    rightFilter = right;
    composition = FilterComposition.And;
  }
  TreeFilter.or(TreeFilter left, TreeFilter right) {
    leftFilter = left;
    rightFilter = right;
    composition = FilterComposition.Or;
  }
}