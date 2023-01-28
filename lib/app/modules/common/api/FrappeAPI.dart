
import 'package:dio/dio.dart';
import 'package:leacc_factory/app/modules/http/dio.dart';

class FrappeAPI{

  
  static Future<Response?> getDetail({required String docType,required String name}) async{
    Response? response = await DioClient().get('/resource/$docType/$name');
    return response;
  }
}