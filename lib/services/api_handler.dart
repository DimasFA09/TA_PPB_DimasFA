import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:store_api_flutter_course/consts/api_consts.dart';
import 'package:store_api_flutter_course/models/categories_models.dart';
import 'package:store_api_flutter_course/models/product_models.dart';

class APIHandler {
  static Future<List<dynamic>> getData({required String target}) async {
    var uri = Uri.https(
      BASE_URL,
      "/api/v1/$target",
    );
    var response = await http.get(uri);

    //print("response ${jsonDecode(response.body)}");
    var data = jsonDecode(response.body);
    List tempList = [];
    for (var v in data) {
      tempList.add(v);
      // print("V $v \n\n");
    }
    return tempList;
  }

  static Future<List<ProductModels>> getAllProducts() async {
    List temp = await getData(target: "products");
    return ProductModels.productsFromSnapshot(temp);
  }

  static Future<List<CategoriesModels>> getAllCategories() async {
    List temp = await getData(target: "categories");
    return CategoriesModels.categoriesFromSnapshot(temp);
  }

  static Future<ProductModels> getProductById({required String id}) async {
    var uri = Uri.https(
      BASE_URL,
      "/api/v1/products/$id",
    );
    var response = await http.get(uri);

    //print("response ${jsonDecode(response.body)}");
    var data = jsonDecode(response.body);

    return ProductModels.fromJson(data);
  }

  static Future<List<ProductModels>> getProductsByCategories(
      {required String id}) async {
    var uri = Uri.https(
      BASE_URL,
      "/api/v1/categories/$id",
    );

    var response = await http.get(uri);

    var data = jsonDecode(response.body);

    return ProductModels.productsFromSnapshot(data);
  }
}
