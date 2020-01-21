class ChildOption {
  String _id;
  String _name;

  String get id => this._id;
  String get name => this._name;

  set id(String val) => this._id = val;
  set name(String val) => this._name = val;

  ChildOption.create(Map<String, dynamic> map) {
    this.id = map["id"];
    this.name = map["name"];
  }
}