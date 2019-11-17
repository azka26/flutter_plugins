enum FieldType {
  INTEGER,
  TEXT,
  REAL,
  NUMERIC
}

class FieldDefinition {
  FieldDefinition();
  FieldDefinition.create({FieldType type, bool isPrimary = false}) {
    this.type = type;
    this.isPrimaryKey = isPrimary;
  }

  FieldType _type;
  FieldType get type {
    return this._type;
  }
  set type(FieldType value) {
    this._type = value;
  }

  bool _isPrimaryKey = false;
  bool get isPrimaryKey {
    return this._isPrimaryKey;
  }
  set isPrimaryKey(bool value) {
    this._isPrimaryKey = value;
  }
}

