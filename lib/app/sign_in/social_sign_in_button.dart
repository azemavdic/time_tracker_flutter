import 'package:flutter/material.dart';
import 'package:time_tracker/app/common_widgets/custom_elevated_button.dart';

class SocialSignInButton extends CustomElevatedButton {
  SocialSignInButton({
    @required String text,
    Color backgroundColor,
    Color textColor,
    VoidCallback onPressed,
    @required String socialImage,
  })  : assert(socialImage != null),
        assert(text != null),
        super(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset('images/$socialImage\-logo.png'),
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
