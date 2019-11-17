import 'package:sqlitetransaction/base/model_base.dart';

import 'province.dart';

class City extends ModelBase {
  String _id;
  String _name;
  Province _province;

  String get id { return this._id; }
  set id(String val) { this._id = val; }

  String get name { return this._name; }
  set name(String val) { this._name = val; }

  Province get province { return this._province; }
  set province(Province val) { this._province = val; }

  @override
  Map<String, dynamic> mapToField() {
    return {
      "id": this.id,
      "name": this.name,
      "province_id": this.province == null ? null : this.province.id
    };
  }
}