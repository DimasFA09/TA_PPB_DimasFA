import 'package:flutter/foundation.dart';

class CategoriesModels with ChangeNotifier {
  int? id;
  String? name;
  String? image;

  CategoriesModels({this.id, this.name, this.image});

  CategoriesModels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
  static List<CategoriesModels> categoriesFromSnapshot(
      List categoriesSmapshot) {
    print("data ${categoriesSmapshot[0]}");
    return categoriesSmapshot.map((data) {
      return CategoriesModels.fromJson(data);
    }).toList();
  }
}
