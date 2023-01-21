import 'package:flutter/material.dart';

class FrappeActionButton extends StatelessWidget {
  late String buttonText;
  // double actionButtonWidth;
  // double actionButtonHeight;
  TextDirection? iconDirectionForButton;
  Icon? buttonIcons;
  Function onPressed;

  FrappeActionButton(
      { required this.buttonText,
      required this.onPressed,
      // required this.actionButtonWidth,
      // required this.actionButtonHeight,
      this.buttonIcons,
      this.iconDirectionForButton});

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      child: Expanded(
        // width: actionButtonWidth,
        // height: actionButtonHeight,
        child: buttonIcons != null
            ? Directionality(
                textDirection: iconDirectionForButton!,
                child: ElevatedButton.icon(
                  onPressed: () => onPressed(),
                  icon: buttonIcons!,
                  label: Text(
                    buttonText,
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue[600],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9)),
                  ),
                ),
              )
            : ElevatedButton(
                onPressed:()=> onPressed(),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue[600],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9)),
                ),
                child: Text(
                  buttonText,
                  style: TextStyle(color: Colors.white),
                ),
              ),
      ),
    );
  }
}
