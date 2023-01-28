import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:leacc_factory/app/modules/expense/controllers/expense_controller.dart';
import 'package:leacc_factory/app/modules/expense/views/expense_view.dart';

import '../../common/views/list_tile.dart';

class ExpenseListView extends GetView<ExpenseController> {
  const ExpenseListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ExpenseController());
    return Scaffold(
        appBar: AppBar(
          title: const Text('Expenses'),
          centerTitle: true,

        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: ()=> Get.to(ExpenseView()),
        ),
        body: Obx(()=>
            LazyLoadScrollView(
              onEndOfPage:()=> controller.endOfReults.value ?Get.snackbar('End of Results', '')
                  : controller.getExpenses(start: controller.expenseList.length),
              child: RefreshIndicator(
                  onRefresh: () async =>  controller.refresh(),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.expenseList.length,
                      itemBuilder:(BuildContext context, int index){
                        return index >= 0 && index < controller.expenseList.length?  Card(
                          child: InkWell(
                            // onTap: ()=>Get.to(()=>ExpenseView(expense: controller.expenseList[index],)),
                            child: FrappeListTile(
                              //controller.expenseList[index]['posting_date']
                              date:  controller.expenseList[index]['posting_date'].toString(),
                              title: controller.expenseList[index]['title'],
                              subtitle: controller.expenseList[index]['name'],
                              trailingText:controller.expenseList[index]['total_credit'].toString(),
                            ),
                          ),
                        ) : const SizedBox.shrink();
                      })
              ),
            ),
        )

    );
  }
}
