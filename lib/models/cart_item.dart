class CartItem {
  int? _id;
  String? _title;
  String? _imageUrl;
  double? _price;
  String? _dateTime;
  int? _quantity;

  CartItem({
    int? id,
    String? title,
    String? image,
    double? price,
    String? dateTime,
    int? quantity,
  }) {
    this._id = id;
    this._title = title;
    this._imageUrl = image;
    this._price = price;
    this._dateTime = dateTime;
    this._quantity = quantity;
  }

  get id => _id;
  get title => _title;
  get image => _imageUrl;
  get price => _price;
  get dateTime => _dateTime;
  get quantity => _quantity;
}
