import 'package:get/get.dart';

import '../modules/expense/bindings/expense_binding.dart';
import '../modules/expense/views/expense_list_view.dart';
import '../modules/expense/views/expense_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/payment/bindings/payment_binding.dart';
import '../modules/payment/views/payment_list_view.dart';
import '../modules/payment/views/payment_view.dart';
import '../modules/purchase/bindings/purchase_binding.dart';
import '../modules/purchase/views/purchase_list_view.dart';
import '../modules/purchase/views/purchase_view.dart';
import '../modules/sales/bindings/sales_binding.dart';
import '../modules/sales/views/sales_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SALES,
      page: () => SalesView(),
      binding: SalesBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT,
      page: () => PaymentView(),
      binding: PaymentBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT_LIST,
      page: () => PaymentListView(),
      binding: PaymentBinding(),
    ),
    GetPage(
      name: _Paths.EXPENSE,
      page: () =>  ExpenseView(),
      binding: ExpenseBinding(),
    ),
    GetPage(
      name: _Paths.EXPENSE_LIST,
      page: () => ExpenseListView(),
      binding: ExpenseBinding(),
    ),
    GetPage(
      name: _Paths.PURCHASE,
      page: () => PurchaseView(),
      binding: PurchaseBinding(),
    ),
    GetPage(
      name: _Paths.PURCHASE_LIST,
      page: () => PurchaseListView(),
      binding: PurchaseBinding(),
    ),

  ];
}
