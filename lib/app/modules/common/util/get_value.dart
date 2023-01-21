
import 'package:dio/dio.dart';
import 'package:leacc_factory/app/modules/http/dio.dart';

class FrappeGet {
  static Future<String> value({required String docType, String fieldName="name", Map<String,dynamic>? filters}) async {
    Map<String,dynamic> queryParams;
    if (filters==null){
      queryParams = {"doctype": docType, "fieldname": fieldName};
    }else{
      queryParams ={"doctype": docType, "fieldname": fieldName,"filters":filters};
    }
        Response? response = await DioClient()
        .get('/method/frappe.client.get_value', queryParameters: queryParams);
    return response?.data['message'][fieldName];
  }

  static Future<List<DropDownItem>> dropDownValue ({required String docType, String txt='', String? referenceDoctype} ) async{
    Response? result = await DioClient().get('/method/frappe.desk.search.search_link',queryParameters: {
      'txt':txt,
      'doctype':docType,
      'reference_doctype':referenceDoctype
    });
    return List.from(result?.data['results']).map((e)=>DropDownItem(e['value'], e['description'])).toList();
  }


}
class DropDownItem{
  late String value;
  late String description;
  DropDownItem(this.value,this.description);
}
