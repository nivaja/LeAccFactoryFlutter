import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';


import 'package:leacc_factory/app/data/payment_provider.dart';
import 'package:leacc_factory/app/modules/payment/controllers/payment_controller.dart';
import 'package:leacc_factory/app/modules/payment/model/PaymentEntryModel.dart';

import '../../common/util/search_delegate.dart';


class PaymentView extends GetView<PaymentController> {
  final _formKey = GlobalKey<FormBuilderState>();
  final Map<String,dynamic>? payment;
  PaymentView({Key? key,this.payment}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => PaymentController());
    return Scaffold(
        appBar: AppBar(
          title: Text('New Payment'),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: FormBuilder(
            enabled: payment == null ? true : false,
            initialValue:payment?.map((key, value) => MapEntry(key, value.toString())) ?? {},
            key: _formKey,
            child: ListView(
              itemExtent: 100,
              children: [
                FormBuilderDateTimePicker(
                  name: 'posting_date',
                  initialEntryMode: DatePickerEntryMode.calendar,
                  initialValue: payment != null ? DateTime.parse(payment!["posting_date"]) : DateTime.now(),
                  inputType: InputType.both,
                  decoration: FrappeInputDecoration(
                      label: 'Posting Date',
                      fieldIcons: const Icon(Icons.date_range)
                  ) ,
                ),
                FormBuilderDropdown<String>(
                  name: 'payment_type',
                  items:['Pay','Receive'].map((e) => DropdownMenuItem(value:e,child: Text(e))).toList(),
                  decoration: FrappeInputDecoration(
                      label: 'Payment Type',
                      fieldIcons: const Icon(Icons.home_repair_service_outlined)
                  ) ,
                  onChanged: (val){
                  },
                ),
                FormBuilderTextField(
                  name: "party",
                  validator: FormBuilderValidators.required(),
                  readOnly: true,
                  decoration: FrappeInputDecoration(
                      label: 'Party',
                      fieldIcons: const Icon(Icons.account_balance_wallet_outlined)
                  ),
                  onTap: () async{
                    _formKey.currentState?.fields['party']?.didChange(
                        await showSearch(
                            context: context,
                            delegate: FrappeSearchDelegate(docType: _formKey.currentState?.fields['payment_type']!.value == "Pay" ? "Supplier":"Customer",
                              referenceDoctype: 'Payment Entry',
                            )
                        )
                    );
                  } ,
                ),

                payment != null ? FormBuilderTextField(
                    initialValue: payment!["payment_type"] == "Pay" ? payment!["paid_from"] : payment!["paid_to"],
                    name: 'payment_account',
                    decoration: FrappeInputDecoration(
                        label: 'Mode of Payment',
                        fieldIcons: const Icon(Icons.payment)
                    )) :

                FutureBuilder(
                    future: controller.getPaymentAccount(),
                    builder: (context,snapshot) {


                      if (snapshot.connectionState == ConnectionState.done) {
                        // If we got an error
                        if (snapshot.hasError) {
                          print(snapshot.error);
                          return Center(
                            child: Text(
                              '${snapshot.error} occurred',
                              style: TextStyle(fontSize: 18),
                            ),
                          );

                          // if we got our data
                        } else if (snapshot.hasData) {
                          print(snapshot.data);
                          // Extracting data from snapshot object
                          final data = snapshot.data as List<String>;
                          return   FormBuilderDropdown<String>(
                            name: 'payment_account',

                            items:(data.map((e) => DropdownMenuItem(child: Text(e),value: e))).toList(),
                            decoration: FrappeInputDecoration(
                                label: 'Mode of Payment',
                                fieldIcons: const Icon(Icons.payment)
                            ) ,
                          );
                        }
                      }

                      // Displaying LoadingSpinner to indicate waiting state
                      return Center(
                        child: CircularProgressIndicator(),
                      );


                    }
                ),


                FormBuilderTextField(
                    name: 'paid_amount',
                    validator: FormBuilderValidators.required(),
                    keyboardType: TextInputType.number,
                    decoration: FrappeInputDecoration(
                        label: 'Paid Amount',
                        fieldIcons: const Icon(Icons.attach_money)
                    )
                ),
                payment!=null?
                    SizedBox.shrink():
                Row(
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.saveAndValidate() ?? false) {
                            print(_formKey.currentState?.value);
                            Map<String,dynamic> data = new Map.from(_formKey.currentState!.value);
                            data['party_type']= _formKey.currentState!.fields['payment_type']!.value == "Pay" ? "Supplier":"Customer";
                            print(data);
                            PaymentProvider().savePaymentEntry(PaymentEnterModel.fromJson(data));
                          } else {
                            print(_formKey.currentState?.value);
                            debugPrint('validation failed');
                          }
                        },
                        child: const Text(
                          'Submit',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          _formKey.currentState?.reset();
                        },
                        // color: Theme.of(context).colorScheme.secondary,
                        child: Text(
                          'Reset',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary),
                        ),
                      ),
                    ),
                  ],
                ),


              ],
            ),
          ),


        )
    );
  }

  InputDecoration FrappeInputDecoration(
      {required String label, required Icon fieldIcons}) {
    return InputDecoration(
        fillColor: Colors.grey[100],
        filled: true,
        border: OutlineInputBorder(),
        icon: fieldIcons,
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.blue[600],
        )
    );
  }
}