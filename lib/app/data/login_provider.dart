import 'package:dio/dio.dart';

import '../modules/http/dio.dart';
import '../modules/http/http.dart';

class LoginProvider{
  Future<Response?> post({required String server, required String usr, required String pwd}) async{
    var data = {
      'usr':usr,
      'pwd':pwd
    };
    await setBaseUrl(server);
    Response? response = await DioClient().post('$server/api/method/login',data: data);
      if(response?.statusCode == 200){

        return response;
    }else {
        await clearConfigStorage();
      }

  }
}
