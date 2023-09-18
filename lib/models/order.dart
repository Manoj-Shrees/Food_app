class Order {
  int? _id;
  String? _title;
  String? _imageUrl;
  double? _price;
  String? _dateTime;

  Order({
    int? id,
    String? title,
    String? image,
    double? price,
    String? dateTime,
  }) {
    _id = id;
    _title = title;
    _imageUrl = image;
    _price = price;
    _dateTime = dateTime;
  }
  get id => _id;
  get title => _title;
  get image => _imageUrl;
  get price => _price;
  get dateTime => _dateTime;
}
