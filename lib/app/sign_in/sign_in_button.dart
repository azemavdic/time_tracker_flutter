import 'package:flutter/material.dart';
import 'package:time_tracker/common_widgets/custom_elevated_button.dart';

class SignInButton extends CustomElevatedButton {
  SignInButton({
    @required String text,
    Color backgroundColor,
    Color textColor,
    VoidCallback onPressed,
    IconData icon,
  })  : assert(text != null),
        super(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                icon,
                size: 30.0,
              ),
              Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontSize: 15.0,
                ),
              ),
              SizedBox(),
            ],
          ),
          backgroundColor: backgroundColor,
          onPressed: onPressed,
        );
}
