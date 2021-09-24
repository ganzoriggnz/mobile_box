class Product {
  final int id, total, price;
  final String name, imgLink, description, createdDate;

  Product(this.id, this.total, this.price, this.name, this.imgLink, this.description, this.createdDate);

  Product.fromJson(Map<String, dynamic> json)
      : id = json["id"],
      total = json["total"],
      name = json["name"],
      price = json["price"],
      description = json["description"],
      imgLink = json["imgLink"],
      createdDate = json["createdDate"];
}
