import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:leacc_factory/app/modules/common/api/FrappeAPI.dart';
import 'package:leacc_factory/app/modules/sales/controllers/sales_controller.dart';

import '../../common/util/search_delegate.dart';
import '../../common/views/list_tile.dart';
import '../model/sales_model.dart';
import 'sales_view.dart';

class SalesListView extends GetView<SalesController> {
  const SalesListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SalesController());
    return Scaffold(
        appBar: AppBar(
            title: const Text('Sales'),
            centerTitle: true,
            actions:[
              // Navigate to the Search Screen
              IconButton(
                  onPressed: () async{
                    String sales_invoice=await showSearch(context: context, delegate: FrappeSearchDelegate(
                      docType: 'Sales Invoice',
                    )
                    );
                    SalesInvoice salesInvoice = await controller.getSale(name: sales_invoice);
                    Get.to(()=>SalesView(salesInvoice: salesInvoice,));
                  }
                  ,
                  icon: const Icon(Icons.search))
            ]

        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: ()=> Get.to(SalesView()),
        ),
        body: Obx(()=>
            LazyLoadScrollView(
              onEndOfPage:()=> controller.endOfReults.value ?Get.snackbar('End of Results', '')
                  : controller.getSaless(start: controller.salesList.length),
              child: RefreshIndicator(
                  onRefresh: () async =>  controller.refresh(),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.salesList.length,
                      itemBuilder:(BuildContext context, int index){
                        return index >= 0 && index < controller.salesList.length?  Card(
                          child: InkWell(
                            onTap: () async{
                              SalesInvoice salesInvoice = await controller.getSale(name: controller.salesList[index]['name']);
                              Get.to(()=>SalesView(salesInvoice: salesInvoice,));
                            },
                            child: FrappeListTile(
                              status:controller.salesList[index]['status'].toString(),
                              date:  controller.salesList[index]['posting_date'].toString(),
                              title: controller.salesList[index]['customer'],
                              subtitle: controller.salesList[index]['name'],
                              trailingText:controller.salesList[index]['total'].toString(),
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
