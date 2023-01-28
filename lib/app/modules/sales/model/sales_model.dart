

import 'sales_item.dart';

class SalesInvoice {
  // SalesInvoice({
  //   this.docstatus=0,
  //   required this.customer,
  //
  //   required this.postingDate,
  //   required this.postingTime,
  //   required this.dueDate,
  //   required this.isPos,
  //   required this.updateStock,
  //   required this.items,
  //   required this.payments,
  // });
  SalesInvoice();
  int docStatus=0;
  late final String customer;
  late final String postingDate;
  //late final String postingTime;
//  late final String dueDate;
  final int isPos=1;
  final int updateStock=1;
  late List<SalesItem> items;

  // SalesInvoice.fromJson(Map<String, dynamic> json){
  //   docstatus = json['data']['docstatus'];
  //   customer = json['data']['customer'];
  //   postingDate = json['data']['posting_date'];
  //   postingTime = json['data']['posting_time'];
  //   dueDate = json['data']['due_date'];

  //

  //   isPos = json['data']['is_pos'];
  //   updateStock = json['data']['update_stock'];
  //   items = List.from(json['data']['items']).map((e)=>Item.fromJson(e)).toList();
  //   payments = List.from(json['data']['payments']).map((e)=>SalesPayment.fromJson(e)).toList();
  // }

  Map<String, dynamic> toJson() {
    final _salesInvoiceData = <String, dynamic>{};
    _salesInvoiceData['docstatus'] = docStatus;
    _salesInvoiceData['customer'] = customer;
    _salesInvoiceData['posting_date'] = postingDate;
    //  _salesInvoiceData['posting_time'] = postingTime;
    // _salesInvoiceData['due_date'] = dueDate;
    _salesInvoiceData['is_pos'] = isPos;
    _salesInvoiceData['update_stock'] = updateStock;
    // _salesInvoiceData['items'] = items.map((e)=>e.toJson()).toList();

    final data = <String,dynamic>{
      'data':_salesInvoiceData
    };
    return data;
  }
}

class SalesPayment {
  SalesPayment({
    required this.modeOfPayment,
    required this.amount,
  });
  late final String modeOfPayment;
  late final double amount;

  SalesPayment.fromJson(Map<String, dynamic> json){
    modeOfPayment = json['mode_of_payment'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final _salesInvoiceData = <String, dynamic>{};
    _salesInvoiceData['mode_of_payment'] = modeOfPayment;
    _salesInvoiceData['amount'] = amount;
    return _salesInvoiceData;
  }
}