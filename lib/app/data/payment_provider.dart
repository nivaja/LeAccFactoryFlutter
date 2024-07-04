


import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:leacc_factory/app/modules/payment/model/PaymentEntryModel.dart';

import '../modules/http/dio.dart';


class PaymentProvider{
  savePaymentEntry(PaymentEnterModel paymentEntry) async{
    Response? response = await DioClient().post('/resource/Payment Entry',data:paymentEntry.toJson());
    if (response?.statusCode ==200){
      AwesomeDialog(
        context: navigator!.context,
        dialogType: DialogType.success,
        animType: AnimType.scale,
        title: 'Success',
        desc: 'Your Payment Has Been Saved',
        btnOkOnPress: () {},
      ).show();
    }

  }

  Future<List<String>> getPaymentAccountList() async{
    Response? result = await DioClient().get('/method/frappe.desk.search.search_link?txt=&doctype=Account&ignore_user_permissions=0&reference_doctype=Payment+Entry&filters=%7B%22account_type%22%3A%5B%22in%22%2C%5B%22Bank%22%2C%22Cash%22%5D%5D%2C%22is_group%22%3A0%7D');
    return List.from(result?.data['message']).map((e) => e['value'].toString()).toList();
  }

  Future<List<Map<String,dynamic>>> getPayments(int start, int length) async{
    // Response? result = await DioClient().get('/resource/Payment Entry?'
    //     'limit_page_length=30'
    //     '&limit_start=0'
    //     '&fields=["name","docstatus","payment_type","paid_amount","party","posting_date","status","modified"]'
    // );

    Response? result = await DioClient().get('/resource/Payment Entry',queryParameters: {
      "limit_page_length":length,// returns 20 records at a time
      "limit_start":start, //Starting index of the record
      // "order_by":"name", //Orders records based on given field
      "fields":jsonEncode(["name","docstatus","payment_type","paid_amount","party","posting_date","status","modified","paid_to","paid_from"]) // reuturns listed fields data
      //"filters":[["posting_date", "=", "2022-06-21"]] //returns data matching filter query
    });
    return List.from(result?.data['data']).map((e) => e as Map<String,dynamic>).toList();
  }
}
