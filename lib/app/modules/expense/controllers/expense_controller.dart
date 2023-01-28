import 'package:get/get.dart';
import '../../../data/expense_provider.dart';
import '../../../data/payment_provider.dart';

class ExpenseController extends GetxController {
  var expenseList = <Map<String,dynamic>>[].obs;
  RxBool isLoading = false.obs;
  Rx<bool> endOfReults = false.obs;
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

  Future<List<String>> getPaymentAccount() async {
    return await PaymentProvider().getPaymentAccountList();
  }
  void refresh() async{
    expenseList.clear();
    await getExpenses();
  }

  getExpenses({int start=0, int length=10}) async{
    try {
      isLoading(true);
      var expenses =  await ExpenseProvider().getExpenses(start,length);
      endOfReults(expenses.isEmpty);
      expenseList.addAll(expenses);
    } finally {
      isLoading(false);
    }
  }

}
