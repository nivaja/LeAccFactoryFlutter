class SalesItem {
  SalesItem({
    required this.itemCode,
    required this.qty,
    required this.rate,
    this.itemName,
    this.amount

  });

  late final String itemCode;
  late final double qty;
  late final double rate;
  String? itemName;
  double? amount;


  SalesItem.fromJson(Map<String, dynamic> json) {
    itemCode = json['item_code'];
    qty = json['qty'];
    rate = json['rate'];
    itemName=json['item_name'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final _purchaseInvoiceData = <String, dynamic>{};
    _purchaseInvoiceData['item_code']=itemCode;
    _purchaseInvoiceData['qty']=qty;
     _purchaseInvoiceData['rate']=rate;
    _purchaseInvoiceData['amount']=rate;
     return _purchaseInvoiceData;
  }




}
