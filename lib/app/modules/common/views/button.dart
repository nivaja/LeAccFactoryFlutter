import 'package:flutter/material.dart';

class FrappeButtonField extends StatelessWidget {
  late String buttonText;
  late TextStyle buttonTextColor;
  double buttonWidth;
  double buttonHeight;
  Function onPressed;

  FrappeButtonField({required this.buttonText, required this.buttonTextColor, this.buttonWidth=100, this.buttonHeight=40, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
        child : SizedBox(
          width: buttonWidth,
          height: buttonHeight,
          child: ElevatedButton(
            onPressed:()=> onPressed(),
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            ),
            child: Text(
              buttonText,
              style: buttonTextColor,
            ),
          ),
        )
    );
  }
}
