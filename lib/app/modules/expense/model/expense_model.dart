class ExpenseModel{
  int docStatus = 0;
  DateTime? posting_date;
  String? user_remark;
  String? expense_account;
  String? payment_account;
  double? amount;

  ExpenseModel(
  {
    this.posting_date,
    this.user_remark,
    this.expense_account,
    this.payment_account,
    this.amount
}
      );

  // ExpenseModel.fromJson(Map<String,dynamic> json){
  //   posting_date = json['data']['posting_date'];
  //   user_remark = json['data']['user_remark'];
  //   expense_account = ['Cash','Bank'].contains(json['data']['accounts'][0]['account_type'])
  //       ? json['data']['accounts'][0]['account']
  //       : json['data']['accounts'][0]['against_account'];
  //   payment_account = ['Cash','Bank'].contains(json['data']['accounts'][0]['account_type'])
  //       ? json['data']['accounts'][0]['account']
  //       : json['data']['accounts'][0]['against_account'];
  //   amount = json['data']['total_credit'];
  // }

  // ExpenseModel.fromJson(Map<String,dynamic> json){
  //   posting_date = json['posting_date'];
  //   user_remark = json['user_remark'];
  //   expense_account = ['Cash','Bank'].contains(json['accounts'][0]['account_type'])
  //       ? json['accounts'][0]['account']
  //       : json['accounts'][0]['against_account'];
  //   payment_account = ['Cash','Bank'].contains(json['accounts'][0]['account_type'])
  //       ? json['accounts'][0]['account']
  //       : json['accounts'][0]['against_account'];
  //   amount = json['total_credit'];
  // }

  ExpenseModel.fromJson(Map<String,dynamic> json){
    posting_date = json['posting_date'];
    user_remark = json['user_remark'];
    expense_account = json['expense_account'];
    payment_account = json['payment_account'];
    amount = double.parse(json['expense_amount']);
  }

  toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['docStatus']=this.docStatus;
    data['posting_date']=this.posting_date.toString();
    data['user_remark']=this.user_remark;
    data['title']='${this.expense_account} <-> ${this.payment_account}';
    data['accounts']=[{
      "account":this.payment_account,
      "credit_in_account_currency":this.amount
    },
      {
        "account":this.expense_account,
        "debit_in_account_currency":this.amount
      }
    ];
    return {'data':data};
  }
}