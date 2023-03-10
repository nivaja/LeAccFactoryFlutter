import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:leacc_factory/app/modules/common/api/FrappeAPI.dart';
import 'package:leacc_factory/app/modules/purchase/controllers/purchase_controller.dart';

import '../../common/util/search_delegate.dart';
import '../../common/views/list_tile.dart';
import '../model/purchase_model.dart';
import 'purchase_view.dart';

class PurchaseListView extends GetView<PurchaseController> {
  const PurchaseListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => PurchaseController());
    return Scaffold(
        appBar: AppBar(
            title: const Text('Purchases'),
            centerTitle: true,
            actions:[
              // Navigate to the Search Screen
              IconButton(
                  onPressed: () async{
                    String purchase_invoice=await showSearch(context: context, delegate: FrappeSearchDelegate(
                      docType: 'Purchase Invoice',
                    )
                    );
                    PurchaseInvoice purchaseInvoice = await controller.getPurchase(name: purchase_invoice);
                    Get.to(()=>PurchaseView(purchaseInvoice: purchaseInvoice,));
                  }
                  ,
                  icon: const Icon(Icons.search))
            ]

        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: ()=> Get.to(PurchaseView()),
        ),
        body: Obx(()=>
            LazyLoadScrollView(
              onEndOfPage:()=> controller.endOfReults.value ?Get.snackbar('End of Results', '')
                  : controller.getPurchases(start: controller.purchaseList.length),
              child: RefreshIndicator(
                  onRefresh: () async =>  controller.refresh(),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.purchaseList.length,
                      itemBuilder:(BuildContext context, int index){
                        return index >= 0 && index < controller.purchaseList.length?  Card(
                          child: InkWell(
                            onTap: () async{
                              PurchaseInvoice purchaseInvoice = await controller.getPurchase(name: controller.purchaseList[index]['name']);
                              Get.to(()=>PurchaseView(purchaseInvoice: purchaseInvoice,));
                            },
                            child: FrappeListTile(
                              status:controller.purchaseList[index]['status'].toString(),
                              date:  controller.purchaseList[index]['posting_date'].toString(),
                              title: controller.purchaseList[index]['supplier'],
                              subtitle: controller.purchaseList[index]['name'],
                              trailingText:controller.purchaseList[index]['total'].toString(),
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
