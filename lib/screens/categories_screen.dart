import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:store_api_flutter_course/models/categories_models.dart';
import 'package:store_api_flutter_course/screens/feeds_screen.dart';
import 'package:store_api_flutter_course/widget/category_widget.dart';

import '../services/api_handler.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Kategori")),
      body: FutureBuilder<List<CategoriesModels>>(
        future: APIHandler.getAllCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("An error occurred ${snapshot.error}"),
            );
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("No products have been added yet"),
            );
          }
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: snapshot.data!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 0.0,
              mainAxisSpacing: 0.0,
              childAspectRatio: 1.2,
            ),
            itemBuilder: (ctx, index) {
              return GestureDetector(
                onTap: () {
                  // Navigasi ke halaman baru saat kategori diklik
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      child: const FeedsScreen(),
                    ),
                  );
                },
                child: ChangeNotifierProvider.value(
                  value: snapshot.data![index],
                  child: const CategoryWidget(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class DetailCategoryScreen extends StatelessWidget {
  final CategoriesModels category;

  const DetailCategoryScreen({Key? key, required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(category.name.toString())),
      body: const FeedsScreen(),
    );
  }
}
