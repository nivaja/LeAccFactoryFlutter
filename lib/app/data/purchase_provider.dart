
import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../modules/http/dio.dart';
import '../modules/purchase/model/purchase_model.dart';

class PurchaseProvider{
  savePurchase(PurchaseInvoice purchaseInvoice) async{
    print(purchaseInvoice.toJson());
    Response? response = await DioClient().post('/resource/Purchase Invoice',data:purchaseInvoice.toJson());
    if (response!.statusCode ==200){
      AwesomeDialog(
        context: navigator!.context,
        dialogType: DialogType.success,
        animType: AnimType.scale,
        title: 'Success',
        desc: 'Your Purchase Has Been Saved',
        btnOkOnPress: () {},
      ).show();
    }

  }

    Future<List<Map<String,dynamic>>> getPurchases(int start, int length) async{
      Response? result = await DioClient().get('/resource/Purchase Invoice',queryParameters: {
        "limit_page_length":length,// returns 20 records at a time
        "limit_start":start, //Starting index of the record
        "fields":jsonEncode(["name","docstatus","supplier","total","posting_date","modified","purchase_bill_no","total_qty"]) // reuturns listed fields data
      });
      return List.from(result?.data['data']).map((e) => e as Map<String,dynamic>).toList();
  }
}
