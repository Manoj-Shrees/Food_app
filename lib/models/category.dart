class Category {
  String? _name;
  String? _image;

  Category({required String name, required String image}) {
    this._name = name;
    this._image = image;
  }

  get name => _name;
  get image => _image;
}
