import 'package:get/get.dart';
import 'package:leacc_factory/app/data/payment_provider.dart';


class PaymentController extends GetxController {
  var paymentList = <Map<String,dynamic>>[].obs;
  RxBool isLoading = false.obs;
  Rx<bool> endOfReults = false.obs;
  @override
  void onInit() async{
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
  Future<List<String>> getPaymentAccount() async {
    return await PaymentProvider().getPaymentAccountList();
  }

  void refresh() async{
    paymentList.clear();
    await getPayments();
  }

  getPayments({int start=0, int length=10}) async{
    try {
      isLoading(true);
      var payments =  await PaymentProvider().getPayments(start,length);
      endOfReults(payments.isEmpty);
      paymentList.addAll(payments);
    } finally {
      isLoading(false);
    }
  }
}
