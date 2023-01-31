import 'package:flutter/material.dart';
import 'package:leacc_factory/app/modules/preference/views/preference_view.dart';


import 'package:leacc_factory/app/modules/sales/views/sales_view.dart';

import '../../expense/views/expense_list_view.dart';
import '../../login/views/login_view.dart';
import '../../payment/views/payment_list_view.dart';
import '../../purchase/views/purchase_list_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currentIndex = 0;
  static  List<Widget> widgetOptions = <Widget>[
    SalesView(),
    PurchaseListView(),
    PaymentListView(),
    ExpenseListView(),
    PreferenceView(),


  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: IndexedStack(
        index: currentIndex,
        children: widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        // selectedIconTheme:IconThemeData(color: Colors.grey),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.shifting,
        currentIndex: currentIndex,
        selectedItemColor: Colors.blue,
        onTap: (index) => setState(() => currentIndex = index),
        items: const <BottomNavigationBarItem>[

          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag), label: 'Sales'),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_shopping_cart_sharp), label: 'Purchase'),
          BottomNavigationBarItem(icon: Icon(Icons.money), label: 'Payment'),

          BottomNavigationBarItem(icon: Icon(Icons.attach_money_outlined), label: 'Expense'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined), label: 'Account'),


        ],
      ),
    );
  }
}
