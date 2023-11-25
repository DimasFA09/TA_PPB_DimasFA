import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import '../widget/feeds_widget.dart';
import '../models/product_models.dart';
import '../services/api_handler.dart';

class FeedsScreen extends StatefulWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  List<ProductModels> productList = [];
  @override
  void didChangeDependencies() {
    getProduct();
    super.didChangeDependencies();
  }

  Future<void> getProduct() async {
    productList = await APIHandler.getAllProducts();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // elevation: 5,
        title: const Text('Semua Produk'),
      ),
      body: productList.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              // shrinkWrap: true,
              // physics: const NeverScrollableScrollPhysics(),
              itemCount: productList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 0.0,
                  mainAxisSpacing: 0.0,
                  childAspectRatio: 0.65),
              itemBuilder: (ctx, index) {
                return ChangeNotifierProvider.value(
                    value: productList[index], child: const FeedsWidget());
              }),
    );
  }
}
