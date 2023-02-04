
import 'package:dio/dio.dart';
import 'package:leacc_factory/app/modules/http/dio.dart';

class FrappeAPI{

  
  static Future<Response?> getDetail({required String docType,required String name}) async{
    Response? response = await DioClient().get('/resource/$docType/$name');
    return response;
  }

  static Future<Response?> updateDoc({required String docType,required String name,required Map<String,dynamic> data}) async{
    Response? response = await DioClient().put('/resource/$docType/$name', data: data);
    return response;
  }
}