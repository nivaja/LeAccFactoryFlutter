import 'package:flutter/material.dart';

class FrappeGridView extends StatelessWidget {
  const FrappeGridView({Key? key}) : super(key: key);

  // String itemsIdText;
  // String priceText;
  //
  // FrappeAddItemCard(this.itemsIdText, this.priceText);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(10),
      crossAxisCount: 2,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      shrinkWrap: true,
      children: <Widget>[
       

      ]
      ,
    );
  }
}
