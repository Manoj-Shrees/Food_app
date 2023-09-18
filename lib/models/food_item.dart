class FoodItem {
  int id;
  int? restaurantId;
  double? rating;
  double price;
  double? discountPrice;
  String? crusineType;
  String? name;
  String? description;
  String? picUrl;
  String? restaurantName;
  double? distance;

  FoodItem({
    required this.id,
    this.restaurantId,
    this.rating,
    required this.price,
    this.discountPrice,
    this.crusineType,
    this.name,
    this.description,
    this.picUrl,
    this.restaurantName,
    this.distance,
  });
}
