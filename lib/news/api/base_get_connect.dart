import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';


class BaseGetConnect extends GetConnect {
  @override
  void onInit() {
    super.onInit();
    if (!kReleaseMode) {
      findProxy = (url) =>
      'PROXY ${Platform.isAndroid ? '10.0.2.2' : 'localhost'}:8080; DIRECT';
      allowAutoSignedCert = true;
    }

    baseUrl = 'http://localhost:8080/';

    httpClient.timeout = const Duration(seconds: 30);
  }
}