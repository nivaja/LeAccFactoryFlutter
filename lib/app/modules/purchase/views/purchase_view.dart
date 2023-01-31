import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:get/get.dart';
import 'package:leacc_factory/app/data/purchase_provider.dart';
import 'package:leacc_factory/app/modules/purchase/model/purchase_model.dart';
import 'package:leacc_factory/app/modules/sales/model/sales_item.dart';

import '../../common/util/search_delegate.dart';
import '../controllers/purchase_controller.dart';

class PurchaseView extends GetView<PurchaseController> {
  PurchaseInvoice? purchaseInvoice;
  final _formKey = GlobalKey<FormBuilderState>();
  final _itemFormKey =GlobalKey<FormBuilderState>();
  PurchaseView({this.purchaseInvoice, Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => PurchaseController());


    return Scaffold(
        appBar: AppBar(
          title: Text('New Purchase'),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: FormBuilder(
            key: _formKey,
            initialValue:  purchaseInvoice!=null?
            {
              'posting_date':purchaseInvoice!.postingDate,
              'supplier':purchaseInvoice!.supplier,
              'purchase_bill_no':purchaseInvoice!.purchase_bill_no
            }:{
              'posting_date':DateTime.now(),
            },
            enabled: purchaseInvoice!=null?false:true,
            child: ListView(
              itemExtent: 100,
              children: [
                FormBuilderDateTimePicker(
                  name: 'posting_date',
                  initialEntryMode: DatePickerEntryMode.calendar,
                  inputType: InputType.both,
                  valueTransformer: (val){
                    return val!.toString();
                  },
                  decoration: FrappeInputDecoration(
                      label: 'Posting Date',
                      fieldIcons: const Icon(Icons.date_range)
                  ) ,
                ),
                FormBuilderTextField(
                  name: 'supplier',
                  validator: FormBuilderValidators.required(),
                  decoration: FrappeInputDecoration(
                      label: 'Supplier',
                      fieldIcons: const Icon(Icons.perm_identity)
                  ),
                  onTap: () async{
                    _formKey.currentState?.fields['supplier']?.didChange(
                        await showSearch(
                            context: context,
                            delegate: FrappeSearchDelegate(docType: 'Supplier',
                                referenceDoctype: 'Purchase Invoice')
                        )
                    );

                  },
                ),


                FormBuilderTextField(
                    name: 'purchase_bill_no',
                    validator: FormBuilderValidators.required(),
                    decoration: FrappeInputDecoration(
                        label: 'Bill No',
                        fieldIcons: const Icon(Icons.numbers)
                    )
                ),

                purchaseInvoice==null?
                OutlinedButton(
                  onPressed: () {
                    Get.dialog(
                        AlertDialog(
                          title: const Text('Dialog'),
                          content: ItemForm(_itemFormKey,context),
                        )
                    );
                  },
                  // color: Theme.of(context).colorScheme.secondary,
                  child: Text(
                    'Add Items',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                ):
                    SizedBox.shrink(),
                Container(
                  child:
                  purchaseInvoice!=null?
                  ListView.builder(
                    itemCount: purchaseInvoice!.items.length,
                    itemBuilder: (BuildContext context,int index){
                      return ListTile(
                          leading: const Icon(Icons.list),
                          trailing: Text(
                              (purchaseInvoice!.items[index].rate * purchaseInvoice!.items[index].qty).toString(),

                            style: TextStyle(color: Colors.green, fontSize: 15),
                          ),
                          title: Text("${purchaseInvoice!.items[index].itemCode} ,${purchaseInvoice!.items[index].rate},${purchaseInvoice!.items[index].qty}"));
                    },
                  )

                  :Obx(()=>
                      ListView.builder(
                        itemCount: controller.itemList.length,
                        itemBuilder: (BuildContext context,int index){
                          return ListTile(
                              leading: const Icon(Icons.list),
                              trailing: Text(
                                (controller.itemList[index]['rate'] *controller.itemList[index]['qty']).toString(),
                                style: TextStyle(color: Colors.green, fontSize: 15),
                              ),
                              title: Text("${controller.itemList[index]['item_code']} , ${controller.itemList[index]['rate']},${controller.itemList[index]['qty']}"));
                        },
                      ),
                  ),
                ),
                purchaseInvoice!=null?
                    SizedBox.shrink():
                Row(
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.saveAndValidate() ?? false) {
                            print(_formKey.currentState?.value);
                            var data = new Map.from(_formKey.currentState!.value);
                            data['items']=controller.itemList;
                            print(data);
                            PurchaseProvider().savePurchase(PurchaseInvoice.fromJson({
                              'data':data
                            })
                            );

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
                          controller.clearItems();
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

  Widget ItemForm(GlobalKey<FormBuilderState> formKey,BuildContext context){
    return FormBuilder(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [

          FormBuilderTextField(
              name: 'item_code',
              readOnly: true,
              onTap: () async{
                formKey.currentState?.fields['item_code']?.didChange(
                    await showSearch(
                        context: context,
                        delegate: FrappeSearchDelegate(docType: 'Item',
                            referenceDoctype: 'Purchase Invoice')
                    )
                );
              } ,
              validator: FormBuilderValidators.compose(
                  [FormBuilderValidators.required()]

              ),
              decoration: FrappeInputDecoration(
                  label: 'Product',
                  fieldIcons: const Icon(Icons.production_quantity_limits)
              )
          ),

          FormBuilderTextField(
              name: 'qty',
              keyboardType: TextInputType.number,
              onChanged:
                  (val){
                cal(formKey);
              },
              valueTransformer: (val){
                return double.tryParse(val!);
              },
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
              valueTransformer: (val){
                return double.tryParse(val!);
              },
              onChanged:
                  (val){
                cal(formKey);
              },
              validator: FormBuilderValidators.compose(
                  [FormBuilderValidators.required(),
                    FormBuilderValidators.numeric()]

              ),
              decoration: FrappeInputDecoration(
                  label: 'Rate',
                  fieldIcons: const Icon(Icons.monetization_on_outlined)
              )
          ),
          FormBuilderTextField(
              name: 'amount',
              initialValue: '0',
              readOnly: true,
              valueTransformer: (val){
                return double.tryParse(val!);
              },
              keyboardType: TextInputType.number,
              validator: FormBuilderValidators.compose(
                  [FormBuilderValidators.required(),
                    FormBuilderValidators.numeric()]

              ),
              decoration: FrappeInputDecoration(
                  label: 'Amount',
                  fieldIcons: const Icon(Icons.monetization_on_outlined)
              )
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState?.saveAndValidate() ?? false) {
                      print(formKey.currentState?.value);
                      controller.itemList.add(formKey.currentState!.value);

                    } else {
                      print(formKey.currentState?.value);
                      debugPrint('validation failed');
                    }
                  },
                  child: const Text(
                    'Add Item',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    formKey.currentState?.reset();
                  },
                  // color: Theme.of(context).colorScheme.secondary,
                  child: const Text(
                    'Reset',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  cal(formKey){
    double qty = double.parse(formKey.currentState.fields["qty"].value??"0");
    double rate = double.parse(formKey.currentState.fields["rate"].value??"0");
    if (qty != null || rate != null) {
      formKey.currentState?.fields["amount"]?.didChange((qty * rate).toString());

    } else {
      formKey.currentState?.fields["amount"]?.didChange('0');
      ;
    }
  }
}
