class Product {
  String? uid;
  String? name;
  num? price;
  String? image;

  Product.toJson(Map<String, dynamic> json)
      : uid = json['uid'],
        name = json['name'],
        price = json['price'],
        image = json['image'];
}
