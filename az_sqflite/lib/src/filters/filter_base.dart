import 'package:az_sqflite/src/model_base.dart';

abstract class FilterBase<T extends ModelBase> {
  T modelInstance;
  FilterBase({this.modelInstance});
}