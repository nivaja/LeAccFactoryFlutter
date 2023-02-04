
import 'package:intl/intl.dart';

import 'sales_item.dart';

class SalesInvoice {

  SalesInvoice();
  int docStatus=0;
  late final String customer;
  late final DateTime postingDate;
  late String bill_no;
  String? modified_by;
  String? posting_time;
  final int updateStock=1;
  String? name;
  late List<SalesItem> items;

  SalesInvoice.fromJson(Map<String, dynamic> json){
    name=json['data']['name'];
    docStatus = json['data']['docstatus'];

    customer = json['data']['customer'];
    modified_by=json['data']['modified_by'];
    bill_no = json['data']['bill_no'];
    postingDate = DateTime.parse('${json['data']['posting_date']}');
    posting_time = json['data']['posting_time'];
    items = List.from(json['data']['items']).map((e)=>SalesItem.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _salesInvoiceData = <String, dynamic>{};
    _salesInvoiceData['docstatus'] = docStatus;
    _salesInvoiceData['customer'] = customer;
    _salesInvoiceData['posting_date'] = postingDate.toString();
    _salesInvoiceData['bill_no'] = bill_no;
    _salesInvoiceData['posting_time'] = DateFormat.Hms().format(postingDate);
    _salesInvoiceData['due_date'] = postingDate.add(const Duration(days: 7)).toString();
    _salesInvoiceData['update_stock'] = updateStock;
    _salesInvoiceData['items'] = items.map((e)=>e.toJson()).toList();

    final data = <String,dynamic>{
      'data':_salesInvoiceData
    };
    return data;
  }
}


