import 'package:flutter/material.dart';

class TextContainer extends StatelessWidget {
  late String title;
  String? subtitle;
  TextContainer({Key? key, required this.title, this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
        child: Column(
          children: [
            Text(title),
            Text(subtitle??'')
          ],
        ),
      ),
    );
  }
}
