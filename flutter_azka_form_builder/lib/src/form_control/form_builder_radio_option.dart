class FormBuilderRadioOption {
  String _id;
  String _label;
  dynamic _value;

  String get id => this._id;
  String get label => this._label;
  dynamic get value => this._value;

  set id(String val) => this._id = val;
  set label(String val) => this._label = val;
  set value(dynamic val) => this._value = val;

  FormBuilderRadioOption.create(String id, String label, dynamic value) {
    this.id = id;
    this.label = label;
    this.value = value;
  }

  Map<String, dynamic> toFormValue() {
    Map<String, dynamic> map = {
      "value": this.id,
      "label": this.label
    };
    return map;
  }
}