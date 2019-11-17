abstract class Specification {
  List<dynamic> getSQLParameter();
  String getSQL();
}

class EqualsSpecification extends Specification {
  String fieldName;
  dynamic value;
  EqualsSpecification(this.fieldName, this.value);

  @override
  List<dynamic> getSQLParameter() {
    return [value];
  }

  @override
  String getSQL() {
    return "${this.fieldName} = ?";
  }
}

class AndSpecification extends Specification {
  Specification leftNode;
  Specification rightNode;
  AndSpecification(this.leftNode, this.rightNode);

  @override
  List<dynamic> getSQLParameter() {
    List<dynamic> left = this.leftNode.getSQLParameter();
    if (left == null) left = [];
    List<dynamic> right = this.rightNode.getSQLParameter();
    if (right == null) right = [];
    return [...left, ...right];
  }

  @override
  String getSQL() {
    return "(${this.leftNode.getSQL()} AND ${this.rightNode.getSQL()})";
  }
}

class OrSpecification extends Specification {
  Specification leftNode;
  Specification rightNode;
  OrSpecification(this.leftNode, this.rightNode);

  @override
  List<dynamic> getSQLParameter() {
    List<dynamic> left = this.leftNode.getSQLParameter();
    if (left == null) left = [];
    List<dynamic> right = this.rightNode.getSQLParameter();
    if (right == null) right = [];
    return [...left, ...right];
  }

  @override
  String getSQL() {
    return "(${this.leftNode.getSQL()} OR ${this.rightNode.getSQL()})";
  }
}