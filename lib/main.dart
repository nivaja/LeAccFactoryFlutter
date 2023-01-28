import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/modules/http/http.dart';
import 'app/routes/app_pages.dart';


void main() async{

  await GetStorage.init('Config');
  await initApiConfig();
  runApp(
    GetMaterialApp(
      supportedLocales: const [
        Locale('en'),
      ],

      builder: EasyLoading.init(),
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );

}
