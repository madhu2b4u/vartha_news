import 'package:get/get.dart';

import '../controller/news_controller.dart';
import 'api_provider.dart';


class ApiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiProvider());
    Get.put(NewsController(apiProvider: Get.find()));
  }
}