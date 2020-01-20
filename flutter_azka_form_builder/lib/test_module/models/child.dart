class Child {
  String _id;
  String _name;

  String get id => this._id;
  set id(String val) => this._id = val;

  String get name => this._name;
  set name(String val) => this._name = val;

  Child.create(Map<String, dynamic> map) {
    if (map == null) return;
    this.id = map["id"];
    this.name = map["name"];
  }
}