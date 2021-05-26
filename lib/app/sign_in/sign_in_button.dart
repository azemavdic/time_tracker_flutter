import 'package:flutter/cupertino.dart';
import 'package:time_tracker/app/common_widgets/custom_elevated_button.dart';

class SignInButton extends CustomElevatedButton {
  SignInButton({
    String? text,
    Color? backgroundColor,
    Color? textColor,
    VoidCallback? onPressed,
  }) : super(
          child: Text(
            text!,
            style: TextStyle(color: textColor),
          ),
          backgroundColor: backgroundColor!,
          onPressed: onPressed,
        );
}
