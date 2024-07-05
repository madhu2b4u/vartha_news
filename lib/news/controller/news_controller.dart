// Combined Controller for Categories and News
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../api/api_provider.dart';
import '../data/model/category.dart';
import '../data/model/news.dart';

class NewsController extends GetxController {
  final ApiProvider apiProvider;

  var categories = <Category>[].obs;
  var newsList = <News>[].obs;
  var status = RxStatus.loading().obs;

  NewsController({required this.apiProvider});

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
    fetchPosts(null);
  }

  void updateNewsItem(String id, String summary) {
    var map = {
      "id": id,
      "summary": summary,
    };
    apiProvider.updateNewsItem(map).then((response) {
      debugPrint('URL: ${response.request?.url}');
      debugPrint('bodyString: ${response.bodyString}');
      List<News>? data = newsModelFromJson(response.bodyString ?? '');
      newsList.value = data;
      status.value = RxStatus.success();
    }, onError: (err) {
      status.value = RxStatus.error(err.toString());
    });
  }

  void fetchPosts(String? category) {
    final fetch = category == null
        ? apiProvider.getNews()
        : apiProvider.getNewsByCategory(category);

    fetch.then((response) {
      debugPrint('URL: ${response.request?.url}');
      debugPrint('bodyString: ${response.bodyString}');
      List<News>? data = newsModelFromJson(response.bodyString ?? '');
      newsList.value = data;
      status.value = RxStatus.success();
    }, onError: (err) {
      status.value = RxStatus.error(err.toString());
    });
  }

  void fetchCategories() {
    apiProvider.getCategories().then((response) {
      debugPrint('URL: ${response.request?.url}');
      debugPrint('bodyString: ${response.bodyString}');
      List<Category> data = Category.listFromJson(response.body);
      categories.value = data;
      status.value = RxStatus.success();
    }, onError: (err) {
      status.value = RxStatus.error(err.toString());
    });
  }
}