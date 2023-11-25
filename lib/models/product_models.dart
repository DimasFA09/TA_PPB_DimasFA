import 'package:flutter/foundation.dart';

import 'categories_models.dart';

class ProductModels with ChangeNotifier {
  int? id;
  String? title;
  int? price;
  String? description;
  List<String>? images;
  CategoriesModels? category;

  ProductModels(
      {this.id,
      this.title,
      this.price,
      this.description,
      this.images,
      this.category});

  ProductModels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    description = json['description'];
    images = json['images'].cast<String>();
    category = json['category'] != null
        ? new CategoriesModels.fromJson(json['category'])
        : null;
  }
  static List<ProductModels> productsFromSnapshot(List productSmapshot) {
    print("data ${productSmapshot[0]}");
    return productSmapshot.map((data) {
      return ProductModels.fromJson(data);
    }).toList();
  }
}
