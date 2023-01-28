// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';
//
// class ItemForm extends StatelessWidget{
//   GlobalKey<FormBuilderState> formKey;
//   List<String> itemList;
//   ItemForm({ required this.formKey, required this.itemList})
//
//   @override
//   Widget build(BuildContext context) {
//
//       return FormBuilder(
//         key: formKey,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             FormBuilderDropdown<String>(
//               name: 'items',
//               items:itemList.map((e) => DropdownMenuItem(value:e,child: Text(e))).toList(),
//               decoration: FrappeInputDecoration(
//                   label: 'Product',
//                   fieldIcons: const Icon(Icons.production_quantity_limits)
//               ) ,
//             ),
//             FormBuilderTextField(
//                 name: 'quantity',
//                 keyboardType: TextInputType.number,
//                 validator: FormBuilderValidators.compose(
//                     [FormBuilderValidators.required(),
//                       FormBuilderValidators.numeric()]
//
//                 ),
//                 decoration: FrappeInputDecoration(
//                     label: 'Qty',
//                     fieldIcons: const Icon(Icons.format_list_numbered)
//                 )
//             ),
//             FormBuilderTextField(
//                 name: 'rate',
//                 keyboardType: TextInputType.number,
//                 validator: FormBuilderValidators.compose(
//                     [FormBuilderValidators.required(),
//                       FormBuilderValidators.numeric()]
//
//                 ),
//                 decoration: FrappeInputDecoration(
//                     label: 'Rate',
//                     fieldIcons: const Icon(Icons.monetization_on_outlined)
//                 )
//             ),
//             Row(
//               children: <Widget>[
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       if (formKey.currentState?.saveAndValidate() ?? false) {
//                         print(formKey.currentState?.value);
//                       } else {
//                         print(formKey.currentState?.value);
//                         debugPrint('validation failed');
//                       }
//                     },
//                     child: const Text(
//                       'Add Item',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 20),
//                 Expanded(
//                   child: OutlinedButton(
//                     onPressed: () {
//                       formKey.currentState?.reset();
//                     },
//                     // color: Theme.of(context).colorScheme.secondary,
//                     child: const Text(
//                       'Reset',
//                       style: TextStyle(color: Colors.blue),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       );
//
//   }
//
//   InputDecoration FrappeInputDecoration(
//       {required String label, required Icon fieldIcons}) {
//     return InputDecoration(
//         fillColor: Colors.grey[100],
//         filled: true,
//         border: OutlineInputBorder(),
//         icon: fieldIcons,
//         labelText: label,
//         labelStyle: TextStyle(
//           color: Colors.blue[600],
//         )
//     );
//   }
// }