import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:leacc_factory/app/modules/http/dio.dart';
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
}
