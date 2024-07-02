import 'package:get/get.dart';

import 'base_get_connect.dart';

class ApiProvider extends BaseGetConnect {

  Future<Response<dynamic>> getNews() =>
      get<dynamic>('parsedNews');

  Future<Response<dynamic>> getNewsByCategory(String category) =>
      get<dynamic>('parsedNews/fetchCategory?category=$category}');

  Future<Response<dynamic>> updateNewsItem(Map<String, String> data) =>
      put<dynamic>('parsedNews/${data["id"]}', data);

  Future<Response<dynamic>> getCategories() =>
      get<dynamic>('parsedNews/fetchCategories');

}
