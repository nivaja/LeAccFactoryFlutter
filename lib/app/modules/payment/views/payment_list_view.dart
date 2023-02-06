import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:leacc_factory/app/modules/payment/controllers/payment_controller.dart';
import 'package:leacc_factory/app/modules/payment/model/PaymentEntryModel.dart';
import 'package:leacc_factory/app/modules/payment/views/payment_view.dart';
import 'package:intl/intl.dart';
import '../../common/util/search_delegate.dart';
import '../../common/views/list_tile.dart';

class PaymentListView extends GetView<PaymentController> {
  const PaymentListView({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => PaymentController());
    return Scaffold(
        appBar: AppBar(
          title: const Text('Payments'),
          centerTitle: true,
            actions:[
              // Navigate to the Search Screen
              IconButton(
                  onPressed: () async{
                    String payment=await showSearch(context: context, delegate: FrappeSearchDelegate(
                      docType: 'Payment Entry',
                    )
                    );
                    var paymentMap =await controller.getPayment(name: payment);
                    Get.to(()=>PaymentView(payment: paymentMap));
                  }
                  ,
                  icon: const Icon(Icons.search))
            ]

        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: ()=> Get.to(PaymentView()),
        ),
        body: Obx(()=>
            LazyLoadScrollView(
              onEndOfPage:()=> controller.endOfReults.value ?Get.snackbar('End of Results', '')
                  : controller.getPayments(start: controller.paymentList.length),
              child: RefreshIndicator(
                  onRefresh: () async =>  controller.refresh(),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.paymentList.length,
                      itemBuilder:(BuildContext context, int index){
                        return index >= 0 && index < controller.paymentList.length?  Card(
                          child: InkWell(
                            onTap: ()=>Get.to(PaymentView(payment: controller.paymentList[index],)),
                            child: FrappeListTile(
                              trailingTextColor: controller.paymentList[index]['payment_type']=="Pay"?Colors.red:Colors.green,
                              status:controller.paymentList[index]['status'] ,
                              date:  controller.paymentList[index]['posting_date'],
                              title: controller.paymentList[index]['party'],
                              subtitle: controller.paymentList[index]['name'],
                              trailingText:NumberFormat.currency(symbol: 'Rs.').format(controller.paymentList[index]['paid_amount']),
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
