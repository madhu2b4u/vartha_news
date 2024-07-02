import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../api/api_provider.dart';
import '../data/model/category.dart';

class CategoryController extends GetxController with StateMixin<List<Category>> {
  final ApiProvider apiProvider;

  CategoryController({required this.apiProvider});

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  void fetchCategories() {
    apiProvider.getCategories().then((response) {
      debugPrint('URL: ${response.request?.url}');
      debugPrint('bodyString: ${response.bodyString}');
      List<Category> data = Category.listFromJson(response.body);
      change(data, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }
}