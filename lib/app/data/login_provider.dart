


import 'package:get/route_manager.dart';

import '../modules/home/views/home_view.dart';
import '../modules/http/dio.dart';
import '../modules/http/http.dart';

class LoginProvider{
  post({required String server, required String usr, required String pwd}) async{
    var data = {
      'usr':usr,
      'pwd':pwd
    };
    await DioClient().post('$server/api/method/login',data: data);
    await setBaseUrl(server);
    Get.offAll(HomeView());
  }
}
