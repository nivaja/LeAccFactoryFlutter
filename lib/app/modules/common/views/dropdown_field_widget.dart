import 'package:flutter/material.dart';

class FrappeDropdownField extends StatefulWidget {
  late Icon dropdownFieldIcons;
  List<String> dropdownList;
  String hint;

  FrappeDropdownField(
      {required this.dropdownFieldIcons,
      required this.dropdownList,
      required this.hint});

  @override
  State<FrappeDropdownField> createState() => _FrappeDropdownFieldState();
}

class _FrappeDropdownFieldState extends State<FrappeDropdownField> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      hint: Text(widget.hint),
      items: widget.dropdownList.map((String items) {
        return DropdownMenuItem(value: items, child: Text(items));
      }).toList(),
      decoration: InputDecoration(
          fillColor: Colors.grey[100],
          filled: true,
          border: const OutlineInputBorder(),
          icon: widget.dropdownFieldIcons,
          // labelText: text,
          labelStyle: TextStyle(
            color: Colors.blue[600],
          )),
      onChanged: (String? value) {},
    );
  }
}
