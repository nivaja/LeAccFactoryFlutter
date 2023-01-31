import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get_storage/get_storage.dart';

import 'package:path_provider/path_provider.dart';

import 'dio_interceptor.dart';

class DioClient {
  static final DioClient _dioClient = DioClient._internal();
  static Dio? dio;

  factory DioClient() {
    return _dioClient;
  }

  DioClient._internal();

  static init(String baseUrl) async {
    var cookieJar = await getCookiePath();
    dio = Dio(BaseOptions(baseUrl: baseUrl))
      ..interceptors.addAll([CookieManager(cookieJar), DioInterceptor()]);
    dio?.options.connectTimeout = 60 * 1000;
    dio?.options.receiveTimeout = 60 * 1000;
  }

  static Future<PersistCookieJar> getCookiePath() async {
    Directory appDocDir = await getApplicationSupportDirectory();
    String appDocPath = appDocDir.path;
    return PersistCookieJar(
        ignoreExpires: true, storage: FileStorage("$appDocPath/.cookies/"));
  }

  static Future<String?> getCookies() async {
    var cookieJar = await getCookiePath();
    if (GetStorage('Config').read('baseUrl') != null) {
      var cookies = await cookieJar.loadForRequest(Uri.parse(GetStorage('Config').read('baseUrl')));

      var cookie = CookieManager.getCookies(cookies);

      return cookie;
    } else {
      return null;
    }
  }

  Future<Response?> post(String endpoint, {Map<String, dynamic>? data}) async {
    try {
      EasyLoading.show(
          maskType: EasyLoadingMaskType.black,
          indicator: CircularProgressIndicator(backgroundColor: Colors.white),
          status: 'Please Wait...');
      Response? response = await dio?.post(endpoint, data: data);
         return response;
    } on DioError catch (e) {

        print(e.response?.data);
        AwesomeDialog(
        context: navigator!.context,
        dialogType: DialogType.error,
        animType: AnimType.scale,
        title: e.response?.statusMessage,

        desc: e.response?.data['exception'],
        btnOkOnPress: () {},
      ).show();
    }finally{
      EasyLoading.dismiss();
    }
  }

  Future<Response?> get(String endpoint, {Map<String, dynamic>? queryParameters}) async {
//    try {
      Response? response = await dio?.get(endpoint, queryParameters: queryParameters);
      print(response);
      return response;
    // } on Exception catch (e) {
    //   print(e.toString());
    //
    //  // getx.Get.defaultDialog(title: 'Error', middleText: e.toString());
    // }
  }
}
