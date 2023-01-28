import 'package:flutter/material.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import '../model/sales_item.dart';

class SalesView extends StatelessWidget {
  List<SalesItem> salesItems = [];
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('New Sales'),
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
                  FormBuilderDropdown<String>(
                    name: 'customer',
                    items:['Ram','Hari'].map((e) => DropdownMenuItem(value:e,child: Text(e))).toList(),
                    decoration: FrappeInputDecoration(
                        label: 'Customer',
                        fieldIcons: const Icon(Icons.perm_identity)
                    ) ,
                  ),

                  FormBuilderTextField(
                      name: 'bill_no',
                      validator: FormBuilderValidators.required(),
                      decoration: FrappeInputDecoration(
                          label: 'Bill No',
                          fieldIcons: const Icon(Icons.numbers)
                      )
                  ),
                  FormBuilderDropdown<String>(
                      name: 'items',
                      items:['Aaku','Aqua - 67'].map((e) => DropdownMenuItem(value:e,child: Text(e))).toList(),
                      decoration: FrappeInputDecoration(
                          label: 'Product',
                          fieldIcons: const Icon(Icons.production_quantity_limits)
                      ) ,
                  ),
                  FormBuilderTextField(
                      name: 'quantity',
                      keyboardType: TextInputType.number,
                      validator: FormBuilderValidators.compose(
                        [FormBuilderValidators.required(),
                        FormBuilderValidators.numeric()]

                      ),
                      decoration: FrappeInputDecoration(
                          label: 'Qty',
                          fieldIcons: const Icon(Icons.format_list_numbered)
                      )
                  ),
                  FormBuilderTextField(
                      name: 'rate',
                      keyboardType: TextInputType.number,
                      validator: FormBuilderValidators.compose(
                          [FormBuilderValidators.required(),
                            FormBuilderValidators.numeric()]

                      ),
                      decoration: FrappeInputDecoration(
                          label: 'Rate',
                          fieldIcons: const Icon(Icons.monetization_on_outlined)
                      )
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState?.saveAndValidate() ?? false) {
                              print(_formKey.currentState?.value);
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