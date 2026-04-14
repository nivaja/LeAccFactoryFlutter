import 'package:flutter/material.dart';
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
    if (!Get.isRegistered<PaymentController>()) {
      Get.lazyPut(() => PaymentController());
    }

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
                  PaymentEnterModel paymentEnter = (await controller.getPayment(name: payment)) as PaymentEnterModel;
                  Get.to(()=>PaymentView(payment: paymentEnter.toJson(),));
                }
                ,
                icon: const Icon(Icons.search))
          ]
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Get.to(() => PaymentView()),
      ),
      body: Obx(() {
        // Defensive check: if list is null or empty
        if (controller.paymentList.isEmpty && controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return LazyLoadScrollView(
          onEndOfPage: () =>
          controller.endOfReults.value
              ? null
              : controller.getPayments(start: controller.paymentList.length),
          child: RefreshIndicator(
            onRefresh: () async => controller.refresh(),
            child: ListView.builder(
              itemCount: controller.paymentList.length,
              itemBuilder: (BuildContext context, int index) {
                final item = controller.paymentList[index];

                // If for some reason an item in the list is null, skip it
                if (item == null) return const SizedBox.shrink();

                // 1. Safe parsing of Amount (Handle String, double, or null)
                double amount = 0.0;
                try {
                  if (item['paid_amount'] != null) {
                    amount = double.parse(item['paid_amount'].toString());
                  }
                } catch (e) {
                  amount = 0.0;
                }

                // 2. Safe string conversion for all fields
                String party = item['party']?.toString() ?? 'No Party Name';
                String name = item['name']?.toString() ?? '';
                String date = item['posting_date']?.toString() ?? '';
                String status = item['status']?.toString() ?? '';
                String paymentType = item['payment_type']?.toString() ?? '';

                return Card(
                  child: InkWell(
                    onTap: () => Get.to(() => PaymentView(payment: item)),
                    child: FrappeListTile(
                      trailingTextColor: paymentType == "Pay"
                          ? Colors.red
                          : Colors.green,
                      status: status,
                      date: date,
                      title: party,
                      subtitle: name,
                      trailingText: NumberFormat.currency(symbol: 'Rs.')
                          .format(amount),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      }),
    );
  }
}