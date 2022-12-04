import 'dart:developer';

import 'package:ecommerse/screens/categoryview/view/screen_category_productlist.dart';
import 'package:ecommerse/screens/product/model/product_model.dart';
import 'package:ecommerse/screens/allproducts/view/screen_allproduct.dart';
import 'package:ecommerse/screens/home/model/category/home_category_model.dart';
import 'package:ecommerse/screens/home/service/home_category_service.dart';
import 'package:ecommerse/screens/categoryview/service/category_wisw_product_service.dart';
import 'package:ecommerse/screens/product/service/product_service.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class ScreenHomeProvider with ChangeNotifier {
  ScreenHomeProvider() {
    getAllProducts();
    getAllCategories();
    //getAllCatedoryProducts();
  }

  List favoriteBoolList = List.generate(4, (index) => false);
  List<HomeCategoryModel?> categoryList = [];
  bool isLoading = false;
  List<ProductModel>? product;
  // Products? catedoryProductsList;
  num offerPrice = 0;

  // void navigatorHomeToViewAll(context) {
  //   Navigator.of(context).push(
  //     MaterialPageRoute(
  //       builder: (context) {
  //         return const ScreenAllProduct();
  //       },
  //     ),
  //   );
  // }

  Future<void> getAllCategories() async {
    isLoading = true;
    notifyListeners();
    await HomeCategoryService.homeCategoryService().then((value) {
      if (value.isNotEmpty) {
        categoryList = value;
      }
    });
    isLoading = false;
    notifyListeners();
  }

  void getAllProducts() async {
    isLoading = true;
    notifyListeners();
    await GetAllProductService.getAllProductService().then((value) {
      if (value != null) {
        product = value;
        notifyListeners();
      }else{
        log("get all product is null");
      }
    });
    isLoading = false;
    notifyListeners();
  }

  void calculateOfferPrice(ProductModel product) {
    offerPrice = ((product.price! / 100) * (100 - product.offer!) - 1);
  }

  void categoryView(
    String category,
    String categoryId,
  ) {
     log(categoryId.toString());
    Get.to(
      () => ScreeenCategoryCollection(
        category: category,
        categoryId: categoryId,
      ),
    );
  }
}
