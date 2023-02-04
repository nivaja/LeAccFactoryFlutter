import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../modules/http/dio.dart';
import '../modules/sales/model/sales_model.dart';

class SalesProvider {
  saveSales(SalesInvoice salesInvoice) async{
    Response? response = await DioClient().post('/resource/Sales Invoice',data:salesInvoice.toJson());
    if (response!.statusCode ==200){
      AwesomeDialog(
        context: navigator!.context,
        dialogType: DialogType.success,
        animType: AnimType.scale,
        title: 'Success',
        desc: 'Your Sales Has Been Saved',
        btnOkOnPress: () {},
      ).show();
    }

  }

  Future<List<Map<String,dynamic>>> getSales(int start, int length) async{
    Response? result = await DioClient().get('/resource/Sales Invoice',queryParameters: {
      "limit_page_length":length,// returns 20 records at a time
      "limit_start":start, //Starting index of the record
      "fields":jsonEncode(["name","docstatus","customer","total","posting_date","modified","bill_no","total_qty","status"]) // reuturns listed fields data
    });
    return List.from(result?.data['data']).map((e) => e as Map<String,dynamic>).toList();
  }
}
