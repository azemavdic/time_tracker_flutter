import 'package:flutter/material.dart';
import 'package:time_tracker/app/sign_in/sign_in_button.dart';
import 'package:time_tracker/app/sign_in/social_sign_in_button.dart';
import 'package:time_tracker/services/auth.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key key, @required this.auth}) : super(key: key);
  final AuthBase auth;

  Future<void> _signInAnonimosly() async {
    try {
      await auth.signInAnonymously();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Tracker'),
        elevation: 5.0,
      ),
      body: _buildContent(),
      backgroundColor: Colors.grey.shade200,
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Prijavi se',
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 48.0,
          ),
          SocialSignInButton(
            backgroundColor: Color(0xFF334D92),
            socialImage: 'facebook',
            onPressed: () {},
            text: 'Prijava putem Facebook-a',
            textColor: Colors.white,
          ),
          SizedBox(
            height: 8.0,
          ),
          SocialSignInButton(
            backgroundColor: Colors.white,
            socialImage: 'google',
            onPressed: () {},
            text: 'Prijava putem Google-a',
            textColor: Colors.black87,
          ),
          SizedBox(height: 8.0),
          SignInButton(
            text: 'Prijava putem Emaila',
            textColor: Colors.white,
            backgroundColor: Colors.teal.shade700,
            onPressed: () {},
          ),
          SizedBox(height: 8.0),
          Text(
            'ili',
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.0),
          SignInButton(
            text: 'Anonimna prijava',
            textColor: Colors.black87,
            backgroundColor: Colors.lime.shade400,
            onPressed: _signInAnonimosly,
          ),
        ],
      ),
    );
  }
}
