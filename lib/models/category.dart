class CategoryModel {
  late int id;

  late String name;

  late int price;
  late int period;
  late String created_at;
  late String updated_at;

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    period = json['period'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
  }
}
