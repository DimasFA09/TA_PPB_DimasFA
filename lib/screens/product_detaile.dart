import 'dart:developer';

import 'package:card_swiper/card_swiper.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:store_api_flutter_course/models/product_models.dart';
import 'package:store_api_flutter_course/services/api_handler.dart';

import '../consts/global_colors.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final titleStyle = const TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
  ProductModels? productModels;
  Future<void> getProductInfo() async {
    productModels = await APIHandler.getProductById(id: widget.id);
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    getProductInfo();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: productModels == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(
                        height: 18,
                      ),
                      const BackButton(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              productModels!.category!.name.toString(),
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  flex: 3,
                                  child: Text(
                                    productModels!.title.toString(),
                                    textAlign: TextAlign.start,
                                    style: titleStyle,
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: RichText(
                                    text: TextSpan(
                                        text: '\$',
                                        style: const TextStyle(
                                            fontSize: 25,
                                            color: Color.fromRGBO(
                                                33, 150, 243, 1)),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: productModels!.price
                                                  .toString(),
                                              style: TextStyle(
                                                  color: lightTextColor,
                                                  fontWeight: FontWeight.bold)),
                                        ]),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.4,
                        child: Swiper(
                          itemBuilder: (BuildContext context, int index) {
                            return FancyShimmerImage(
                              width: double.infinity,
                              imageUrl:
                                  productModels!.images![index].toString(),
                              boxFit: BoxFit.fill,
                            );
                          },

                          autoplay: true,
                          itemCount: 3,
                          pagination: const SwiperPagination(
                              alignment: Alignment.bottomCenter,
                              builder: DotSwiperPaginationBuilder(
                                color: Colors.white,
                                activeColor: Colors.red,
                              )),
                          //control: const SwiperControl(),
                        ),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Deskripsi', style: titleStyle),
                            const SizedBox(
                              height: 18,
                            ),
                            Text(
                              productModels!.description.toString(),
                              textAlign: TextAlign.start,
                              style: const TextStyle(fontSize: 25),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )),
    );
  }
}
