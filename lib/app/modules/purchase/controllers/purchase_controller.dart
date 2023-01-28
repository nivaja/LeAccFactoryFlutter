import 'package:get/get.dart';
import 'package:leacc_factory/app/modules/common/api/FrappeAPI.dart';
import 'package:leacc_factory/app/modules/purchase/model/purchase_model.dart';

import '../../../data/purchase_provider.dart';
import '../../sales/model/sales_item.dart';

class PurchaseController extends GetxController {
  var purchaseList = <Map<String,dynamic>>[].obs;
  PurchaseInvoice? purchaseInvoice;
  RxBool isLoading = false.obs;
  Rx<bool> endOfReults = false.obs;
  //TODO: Implement PurchaseController
  var itemList = <SalesItem>[].obs;
  var total=0.0.obs;

  final count = 0.obs;
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
    purchaseList.clear();
    await getPurchases();
  }


  getPurchases({int start=0, int length=10}) async{
    try {
      isLoading(true);
      var purchases =  await PurchaseProvider().getPurchases(start,length);
      endOfReults(purchases.isEmpty);
      purchaseList.addAll(purchases);
    } finally {
      isLoading(false);
    }
  }

  Future<PurchaseInvoice> getPurchase({required String name}) async{
    var response = await FrappeAPI.getDetail(docType: 'Purchase Invoice', name: name);
    return PurchaseInvoice.fromJson(response?.data);
  }
}
