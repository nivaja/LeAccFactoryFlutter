import 'package:get_storage/get_storage.dart';
import 'package:leacc_factory/app/modules/http/dio.dart';

initApiConfig() async{
  var baseUrl = await GetStorage('Config').read('baseUrl');
  if (!["", null].contains(baseUrl)) {
    await DioClient.init('$baseUrl/api');
    await DioClient.getCookies();
  }
}

setBaseUrl(String baseUrl) async{
  await GetStorage('Config').write('baseUrl', '$baseUrl');
  await DioClient.init('$baseUrl/api');
}

clearConfigStorage() async{
  await GetStorage('Config').remove('baseUrl');
}