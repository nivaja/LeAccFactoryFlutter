import 'package:get/get.dart';
import 'package:leacc_factory/app/modules/common/api/FrappeAPI.dart';
import 'package:leacc_factory/app/modules/sales/model/sales_model.dart';

import '../../../data/sales_provider.dart';
import '../../sales/model/sales_item.dart';

class SalesController extends GetxController {
  var salesList = <Map<String,dynamic>>[].obs;
  RxBool isLoading = false.obs;
  Rx<bool> endOfReults = false.obs;
  //TODO: Implement SalesController
  var itemList = <Map<String,dynamic>>[].obs;


  @override
  void onInit() {
    super.onInit();
    refresh();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
  void refresh() async{
    salesList.clear();
    await getSaless();
  }
  void reset(){
    itemList.clear();
  }


  getSaless({int start=0, int length=10}) async{
    try {
      isLoading(true);
      var saless =  await SalesProvider().getSales(start,length);
      endOfReults(saless.isEmpty);
      salesList.addAll(saless);
    } finally {
      isLoading(false);
    }
  }

  Future<SalesInvoice> getSale({required String name}) async{
    var response = await FrappeAPI.getDetail(docType: 'Sales Invoice', name: name);
    return SalesInvoice.fromJson(response?.data);
  }




}
