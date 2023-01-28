class PaymentEnterModel {
  int docstatus=0;
  String? paymentType;
  String? partyType;
  DateTime? postingDate;
  String? party;
  String? paidAmount;
  // String? receivedAmount;
  String? paymentAccount;

  PaymentEnterModel(
      {
        this.paymentType,
        this.partyType,
        this.postingDate,
        this.party,
        this.paidAmount,
        // this.receivedAmount,
        this.paymentAccount});

  PaymentEnterModel.fromJson(Map<String, dynamic> json) {
    paymentType = json['payment_type'];
    partyType = json['party_type'];
    postingDate = json['posting_date'];
    party = json['party'];
    paidAmount = json['paid_amount'];
    // receivedAmount=json['received_amount'];
    paymentAccount = json['payment_account'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['docstatus']=this.docstatus;
    data['payment_type'] = this.paymentType;

    data['party_type'] =  this.partyType;
    data['posting_date'] = this.postingDate.toString();
    data['party'] = this.party;
    data['paid_amount'] = double.parse(this.paidAmount!);
    data['received_amount']=double.parse(this.paidAmount!);
    if (this.paymentType == 'Pay') {
      data['paid_from'] = this.paymentAccount;
    }else{
      data['paid_to'] = this.paymentAccount;
    }
    data['reference_no']="0";
    data['reference_date']=DateTime.now().toString();
    return {'data':data};
  }
}