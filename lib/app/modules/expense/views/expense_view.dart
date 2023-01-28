import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:get/get.dart';
import 'package:leacc_factory/app/data/expense_provider.dart';

import '../../common/util/search_delegate.dart';
import '../controllers/expense_controller.dart';
import '../model/expense_model.dart';


class ExpenseView extends GetView<ExpenseController> {
  final _formKey = GlobalKey<FormBuilderState>();

  ExpenseView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ExpenseController());
    return Scaffold(
        appBar: AppBar(
          title: Text('New Expense'),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: FormBuilder(
            key: _formKey,
            child: ListView(
              itemExtent: 100,
              children: [
                FormBuilderDateTimePicker(
                  name: 'posting_date',
                  initialEntryMode: DatePickerEntryMode.calendar,
                  initialValue: DateTime.now(),
                  inputType: InputType.both,
                  decoration: FrappeInputDecoration(
                      label: 'Posting Date',
                      fieldIcons: const Icon(Icons.date_range)
                  ) ,
                ),

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
                  name: "expense_account",
                  validator: FormBuilderValidators.required(),
                  readOnly: true,
                  decoration: FrappeInputDecoration(
                      label: 'Expense Account',
                      fieldIcons: const Icon(Icons.account_balance_wallet_outlined)
                  ),
                  onTap: () async{
                    _formKey.currentState?.fields['expense_account']?.didChange(
                        await showSearch(
                            context: context,
                            delegate: FrappeSearchDelegate(docType: "Account",
                              referenceDoctype: 'Journal Entry',
                              filters: {
                                "account_type": [
                                  "in",
                                  [
                                    "Expense Account"
                                  ]
                                ],
                                "is_group": 0
                              }
                            )
                        )
                    );
                  } ,
                ),

                FormBuilderTextField(
                    name: 'expense_amount',
                    validator: FormBuilderValidators.required(),
                    keyboardType: TextInputType.number,
                    decoration: FrappeInputDecoration(
                        label: 'Amount',
                        fieldIcons: const Icon(Icons.attach_money)
                    )
                ),
                FormBuilderTextField(
                    name: 'user_remark',
                    validator: FormBuilderValidators.required(),
                    decoration: FrappeInputDecoration(
                        label: 'Remarks',
                        fieldIcons: const Icon(Icons.note_alt_outlined)
                    )
                ),

                Row(
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.saveAndValidate() ?? false) {
                            print({'data':_formKey.currentState!.value});
                            ExpenseProvider().saveExpense(ExpenseModel.fromJson(_formKey.currentState!.value));
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