




import '../../sales/model/sales_item.dart';

class PurchaseInvoice {
  // PurchaseInvoice({
  //   this.docstatus=0,
  //   required this.supplier,
  //
  //   required this.postingDate,
  //   required this.postingTime,
  //   required this.dueDate,
  //   required this.isPos,
  //   required this.updateStock,
  //   required this.items,
  //   required this.payments,
  // });
  // PurchaseInvoice();
  int docStatus=0;
  late final String supplier;
  late final DateTime postingDate;
  late final String purchase_bill_no;
  //late final String postingTime;
//  late final String dueDate;
  int updateStock=1;
  late List<SalesItem> items;

  PurchaseInvoice.fromJson(Map<String, dynamic> json){
    // docStatus = json['data']['docstatus'];
    supplier = json['data']['supplier'];
    purchase_bill_no = json['data']['purchase_bill_no'];
    postingDate = DateTime.parse(json['data']['posting_date']);
    // postingTime = json['data']['posting_time'];
    items =List.from(json['data']['items']).map((e) => SalesItem.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _purchaseInvoiceData = <String, dynamic>{};
    _purchaseInvoiceData['docstatus'] = docStatus;
    _purchaseInvoiceData['supplier'] = supplier;
    _purchaseInvoiceData['posting_date'] = postingDate.toString();
    _purchaseInvoiceData['purchase_bill_no'] = purchase_bill_no;
    //  _purchaseInvoiceData['posting_time'] = postingTime;
    // _purchaseInvoiceData['due_date'] = dueDate;
    _purchaseInvoiceData['update_stock'] = updateStock;
    _purchaseInvoiceData['items'] = items.map((e)=>e.toJson()).toList();

    final data = <String,dynamic>{
      'data':_purchaseInvoiceData
    };
    return data;
  }
}


