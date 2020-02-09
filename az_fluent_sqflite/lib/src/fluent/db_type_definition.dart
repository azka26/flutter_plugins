import 'package:az_fluent_sqflite/src/az_fluent_sqflite.dart';

typedef FilterFunction<T extends ModelBase, U extends FilterBase<T>> = TreeFilter Function(U);