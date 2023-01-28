import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:leacc_factory/app/modules/expense/model/expense_model.dart';

import '../modules/http/dio.dart';

class ExpenseProvider {
  saveExpense(ExpenseModel expenseModel) async{
    print(expenseModel.toJson());
    Response? response = await DioClient().post('/resource/Journal Entry',data:expenseModel.toJson());
    if (response!.statusCode ==200){
      AwesomeDialog(
        context: navigator!.context,
        dialogType: DialogType.success,
        animType: AnimType.scale,
        title: 'Success',
        desc: 'Your Expense Has Been Saved',
        btnOkOnPress: () {},
      ).show();
    }

  }


  Future<List<Map<String,dynamic>>> getExpenses(int start, int length) async{
    // Response? result = await DioClient().get('/resource/Payment Entry?'
    //     'limit_page_length=30'
    //     '&limit_start=0'
    //     '&fields=["name","docstatus","expense_type","paid_amount","party","posting_date","status","modified"]'
    // );

    Response? result = await DioClient().get('/resource/Journal Entry',queryParameters: {
      "limit_page_length":length,// returns 20 records at a time
      "limit_start":start, //Starting index of the record
      // "order_by":"name", //Orders records based on given field
      "fields":jsonEncode(["name","docstatus","title","total_credit","posting_date","modified"]) // reuturns listed fields data
      //"filters":[["posting_date", "=", "2022-06-21"]] //returns data matching filter query
    });
    return List.from(result?.data['data']).map((e) => e as Map<String,dynamic>).toList();
  }


  
}
