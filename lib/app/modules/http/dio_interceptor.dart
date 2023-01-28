import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import 'package:get/get_navigation/src/extension_navigation.dart';

class DioInterceptor extends InterceptorsWrapper{
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print(err.stackTrace.toString());
    super.onError(err, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print("Resquest --> "+jsonEncode(options.data));
    print("Resquest Params --> "+jsonEncode(options.queryParameters.toString()));
    super.onRequest(options,handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print("Response --> "+response.data.toString());
    if (
        response.data != null &&
        response.data["message"] != null) {
      getx.Get.defaultDialog(
          title: response.statusMessage.toString(),
          middleText: response.data["message"].toString()
      );

    }
    switch(response.statusCode){
      case 500:
          AwesomeDialog(
            context: navigator!.context,
            dialogType: DialogType.success,
            animType: AnimType.scale,
            title: response.statusMessage.toString() + response.data['exception'],
            desc: response.data["_server_messages"].toString(),
            btnOkOnPress: () {},
          ).show();
          break;

      case 201:
        getDialog('Created'); break;
      case 401:
        print(response.data);
        getDialog(response.statusMessage);break;
      case 400:
        getDialog(response.statusMessage);break;
    }
    super.onResponse(response, handler);
  }

  getDialog(String? msg){
    return getx.Get.defaultDialog(
        title: msg??'Error',

    );
  }
}