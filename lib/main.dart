import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vartha_news/news/controller/category_controller.dart';
import 'news/api/api_provider.dart';
import 'news/controller/news_controller.dart';
import 'news/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'News App',
      initialBinding: BindingsBuilder(() {
        Get.put(ApiProvider());
        Get.put(CategoryController(apiProvider: Get.find()));
      }),
      home: const SplashScreen(),
    );
  }
}