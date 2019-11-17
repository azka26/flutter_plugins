import 'package:sqlitetransaction/base/model_base.dart';

class Province extends ModelBase {
  int _id;
  String _name;

  int get id { return this._id; }
  set id(int val) { this._id = val; }

  String get name { return this._name; }
  set name(String val) { this._name = val; }

  @override
  Map<String, dynamic> mapToField() {
    return {
      "id": this.id,
      "name": this.name
    };
  }
}