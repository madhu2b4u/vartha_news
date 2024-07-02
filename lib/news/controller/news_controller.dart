import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../api/api_provider.dart';
import '../data/model/newsitem.dart';

class NewsController extends GetxController with StateMixin<List<NewsItem>> {

  final ApiProvider apiProvider;

  NewsController({required this.apiProvider});

  @override
  void onInit() {
    super.onInit();
    fetchPosts(null);
  }

  void updateNewsItem(String id, String summary) {
    var map = {
      "id": id,
      "summary": summary,
    };
    apiProvider.updateNewsItem(map).then((response) {
      debugPrint('URL:${response.request?.url}');
      debugPrint('bodyString:${response.bodyString}');
      List<NewsItem>? data = newsModelFromJson(response.bodyString ?? '');
      change(data, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  void fetchPosts(String? category) {
    final fetch = category == null
        ? apiProvider.getNews()
        : apiProvider.getNewsByCategory(category);

    fetch.then((response) {
      debugPrint('URL:${response.request?.url}');
      debugPrint('bodyString:${response.bodyString}');
      List<NewsItem>? data = newsModelFromJson(response.bodyString ?? '');
      change(data, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }
}
