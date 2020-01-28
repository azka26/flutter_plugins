import 'package:az_fluent_sqflite/src/filter/tree_filter.dart';

extension TreeFilterStringExtension on String {
  TreeFilter fieldEquals(dynamic value) {
    return TreeFilter.equalsFilter(this, value);
  }

  TreeFilter fieldNotEquals(dynamic value) {
    return TreeFilter.notEqualsFilter(this, value);
  }

  TreeFilter fieldLike(dynamic value) {
    return TreeFilter.likeFilter(this, value);
  }

  TreeFilter fieldIn(List<dynamic> values) {
    return TreeFilter.inFilter(this, values);
  }
  
  TreeFilter fieldBetween(dynamic from, dynamic to) {
    return TreeFilter.betweenFilter(this, from, to);
  }
}

extension TreeFilterExtension on TreeFilter {
  TreeFilter and(TreeFilter value) {
    return TreeFilter.and(this, value);
  }
  TreeFilter or(TreeFilter value) {
    return TreeFilter.or(this, value);
  }
}