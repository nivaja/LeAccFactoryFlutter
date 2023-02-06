import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:get/get.dart';
import 'package:leacc_factory/app/data/purchase_provider.dart';
import 'package:leacc_factory/app/modules/common/api/FrappeAPI.dart';

import 'package:leacc_factory/app/modules/purchase/model/purchase_model.dart';

import '../../common/util/search_delegate.dart';
import '../../sales/model/sales_item.dart';
import '../controllers/purchase_controller.dart';
import 'package:intl/intl.dart';
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
          padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
          child: FormBuilder(
            key: _formKey,
            initialValue:  purchaseInvoice!=null?
            {
              'posting_date':purchaseInvoice!.postingDate,
              'supplier':purchaseInvoice!.supplier,
              'purchase_bill_no':purchaseInvoice!.purchase_bill_no,
              'modified_by':purchaseInvoice!.modified_by,
              'posting_time':purchaseInvoice!.posting_time
            }:{
              'posting_date':DateTime.now(),
            },
            enabled: purchaseInvoice!=null?false:true,
            child: ListView(
              shrinkWrap: true,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: FormBuilderDateTimePicker(
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
                    ),
                    purchaseInvoice!=null?Expanded(child: FormBuilderTextField(name: 'posting_time',decoration: InputDecoration(border: OutlineInputBorder(),filled: true),))
                        :SizedBox.shrink()
                  ],
                ),
                SizedBox(height: 15,),
                FormBuilderTextField(
                  name: 'supplier',
                  readOnly: true,
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

                SizedBox(height: 15,),
                FormBuilderTextField(
                    name: 'purchase_bill_no',
                    validator: FormBuilderValidators.required(),
                    decoration: FrappeInputDecoration(
                        label: 'Bill No',
                        fieldIcons: const Icon(Icons.numbers)
                    )
                ),
                SizedBox(height: 15,),
                purchaseInvoice==null?
                SizedBox.shrink()
                    :
                FormBuilderTextField(
                    name: 'modified_by',
                    validator: FormBuilderValidators.required(),
                    decoration: FrappeInputDecoration(
                        label: 'Modified By',
                        fieldIcons: const Icon(Icons.verified_user_outlined)
                    )
                ),
                SizedBox(height: 15,),

                purchaseInvoice==null?
                OutlinedButton(
                  onPressed: () {
                    Get.dialog(
                        AlertDialog(
                          title: const Text('Dialog'),
                          content: ItemForm(formKey: _itemFormKey,context: context),
                        )
                    );
                  },
                  // color: Theme.of(context).colorScheme.secondary,
                  child: Text(
                    'Add Items',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary),
                  ),

                )
                    :
                SizedBox.shrink(),
                SizedBox(height: 15,),
                Container(
                  height: 400,
                  child:
                  purchaseInvoice!=null?
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: purchaseInvoice!.items.length,
                    itemBuilder: (BuildContext context,int index){
                      return ListTile(
                          tileColor: Colors.grey[300],
                          trailing: Text((purchaseInvoice!.items[index].rate * purchaseInvoice!.items[index].qty).toString()),
                          leading: Text(purchaseInvoice!.items[index].itemCode,textAlign: TextAlign.center),
                          title:Text(purchaseInvoice!.items[index].itemName??''),
                          subtitle: Text('Rate: ${purchaseInvoice!.items[index].rate} * Qty: ${purchaseInvoice!.items[index].qty}')
                      );
                    },
                  )

                      :Obx(()=>
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.itemList.length,
                        itemBuilder: (BuildContext context,int index){
                          return Container(
                            margin: EdgeInsets.fromLTRB(0, 10, 0,0),
                            child: Dismissible(
                              key: Key(controller.itemList[index].toString()),
                              onDismissed: (direction){
                                controller.itemList.removeAt(index);
                              },
                              child: ListTile(
                                  onTap: (){
                                    Get.dialog(
                                        AlertDialog(
                                          title: const Text('Edit'),
                                          content: ItemForm(formKey: _itemFormKey,context: context,salesItem:SalesItem.fromJson(controller.itemList[index]),index: index ),
                                        )
                                    );
                                  },
                                  tileColor: Colors.grey[300],
                                  trailing: Text((controller.itemList[index]['rate'] * controller.itemList[index]['qty']).toString()),
                                  leading: Text(controller.itemList[index]['item_code'],textAlign: TextAlign.center),
                                  title:Text(controller.itemList[index]['item_code']),
                                  subtitle: Text('Rate: ${controller.itemList[index]['rate']} * Qty: ${controller.itemList[index]['qty']}')
                              ),
                            ),
                          );
                        },
                      ),
                  ),
                ),
                SizedBox(height: 15,),

                purchaseInvoice!=null ?
                purchaseInvoice!.docStatus != 0 ?
                SizedBox.shrink():
                ElevatedButton(

                  onPressed: (){
                    FrappeAPI.updateDoc(docType: 'Purchase Invoice', name: purchaseInvoice!.name!, data: {"data":{"docstatus":1}});
                  },
                  child: const Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                )
                    :
                Row(
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        onPressed: ()async{
                          if (_formKey.currentState?.saveAndValidate() ?? false) {
                            print(_formKey.currentState?.value);
                            var data = new Map.from(_formKey.currentState!.value);
                            data['items']=controller.itemList;
                            print(data);
                            await PurchaseProvider().savePurchase(PurchaseInvoice.fromJson({
                              'data':data
                             })
                            );
                            _formKey.currentState?.reset();
                            controller.reset();
                          } else {
                            print(_formKey.currentState?.value);
                            debugPrint('validation failed');
                          }
                        },
                        child: const Text(
                          'Save',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          _formKey.currentState?.reset();
                          controller.reset();
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

  Widget ItemForm({required GlobalKey<FormBuilderState> formKey,
    required BuildContext context,
    SalesItem? salesItem, int? index}){

    return FormBuilder(
      key: formKey,
      initialValue: salesItem?.toJson().map((key, value) => MapEntry(key, value.toString())) ?? {},
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
                child: salesItem !=null?ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState?.saveAndValidate() ?? false) {
                      print(formKey.currentState?.value);
                      controller.itemList[index!]=(formKey.currentState!.value);
                      Navigator.pop(context);
                    } else {
                      print(formKey.currentState?.value);
                      debugPrint('validation failed');
                    }
                  },
                  child: const Text(
                    'Edit',
                    style: TextStyle(color: Colors.white),
                  ),
                ):
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState?.saveAndValidate() ?? false) {
                      print(formKey.currentState?.value);
                      controller.itemList.add(formKey.currentState!.value);
                      Navigator.pop(context);
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
