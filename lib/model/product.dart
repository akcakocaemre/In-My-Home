class Product{

  String _name;

  String get name => _name;

  late String _barcode;

  set name(String value) {
    _name = value;
  }

  late String _expDate;


  Product(this._name);

  String get expDate => _expDate;

  set expDate(String value) {
    _expDate = value;
  }
}