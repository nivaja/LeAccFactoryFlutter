



import 'package:intl/intl.dart';
import '../../sales/model/sales_item.dart';

class PurchaseInvoice {
  int? docStatus=0;
  late final String supplier;
  late final DateTime postingDate;
  late final String purchase_bill_no;
  String? modified_by;
  String? posting_time;
  String? name;
int updateStock=1;
  late List<SalesItem> items;

  PurchaseInvoice.fromJson(Map<String, dynamic> json){
    name=json['data']['name'];
    docStatus = json['data']['docstatus'];
    modified_by=json['data']['modified_by'];
    supplier = json['data']['supplier'];
    purchase_bill_no = json['data']['purchase_bill_no']??'';
    postingDate = DateTime.parse('${json['data']['posting_date']}');
    posting_time= json['data']['posting_time'];
    items =List.from(json['data']['items']).map((e) => SalesItem.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _purchaseInvoiceData = <String, dynamic>{};
    _purchaseInvoiceData['docstatus'] = docStatus;
    _purchaseInvoiceData['due_date'] = postingDate.add(const Duration(days: 7)).toString();
    _purchaseInvoiceData['supplier'] = supplier;
    _purchaseInvoiceData['posting_date'] = postingDate.toString();
    _purchaseInvoiceData['purchase_bill_no'] = purchase_bill_no;
     _purchaseInvoiceData['posting_time'] = DateFormat.Hms().format(postingDate);
    _purchaseInvoiceData['update_stock'] = updateStock;
    _purchaseInvoiceData['items'] = items.map((e)=>e.toJson()).toList();

    final data = <String,dynamic>{
      'data':_purchaseInvoiceData
    };
    return data;
  }
}


