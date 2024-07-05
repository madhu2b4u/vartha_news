import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vartha_news/news/api/api_binding.dart';
import 'package:vartha_news/news/screens/news_page.dart';
import 'news/api/api_provider.dart';
import 'news/controller/news_controller.dart';
import 'news/screens/unknown_route_page.dart';
import 'news/splash_screen.dart';


/*void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      initialBinding: BindingsBuilder(() {
        Get.put(ApiProvider());
        Get.put(NewsController(apiProvider: Get.find()));
      }),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NewsPage(),
      unknownRoute: GetPage(
        name: '/notfound',
        page: () => const UnknownRoutePage(),
      ),
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => NewsPage(),
          binding: ApiBinding(),
        ),
        GetPage(
          name: '/NewsPage',
          page: () => NewsPage(),
          binding: ApiBinding(),
        ),
      ],
    );
  }
}*/





void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'News App',
      initialBinding: BindingsBuilder(() {
        Get.put(ApiProvider());
        Get.put(NewsController(apiProvider: Get.find()));
      }),
      home: const SplashScreen(),
    );
  }
}
