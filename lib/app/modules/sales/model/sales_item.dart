class SalesItem {
  SalesItem({
    required this.itemCode,
    required this.qty,
    required this.rate,

  });

  late final String itemCode;
  late final double qty;
  late final double rate;


  SalesItem.fromJson(Map<String, dynamic> json) {
    itemCode = json['item_code'];
    qty = json['qty'];
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final _purchaseInvoiceData = <String, dynamic>{};
    _purchaseInvoiceData['item_code']=itemCode;
    _purchaseInvoiceData['qty']=qty;
     _purchaseInvoiceData['rate']=rate;
     return _purchaseInvoiceData;
  }




}
