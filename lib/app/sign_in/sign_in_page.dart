import 'package:flutter/material.dart';
import 'package:time_tracker/app/sign_in/email_sign_in_page.dart';
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

  Future<void> _signInWithGoogle() async {
    try {
      await auth.signInWithGoogle();
    } catch (e) {
      print(e);
    }
  }

  Future<void> _signInWithFacebook() async {
    try {
      await auth.signInWithFacebook();
    } catch (e) {
      print(e.toString());
    }
  }

  void _signInWithEmail(context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (context) => EmailSignInPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Tracker'),
        elevation: 5.0,
      ),
      body: _buildContent(context),
      backgroundColor: Colors.grey.shade200,
    );
  }

  Widget _buildContent(context) {
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
            onPressed: _signInWithFacebook,
            text: 'Prijava putem Facebook-a',
            textColor: Colors.white,
          ),
          SizedBox(
            height: 8.0,
          ),
          SocialSignInButton(
            backgroundColor: Colors.white,
            socialImage: 'google',
            onPressed: _signInWithGoogle,
            text: 'Prijava putem Google-a',
            textColor: Colors.black87,
          ),
          SizedBox(height: 8.0),
          SignInButton(
            text: 'Prijava putem Emaila',
            textColor: Colors.white,
            backgroundColor: Colors.teal.shade700,
            onPressed: () => _signInWithEmail(context),
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

// keytool -exportcert -alias androiddebugkey -keystore "C:\Users\Asko\.android\debug.keystore"

// keytool -exportcert -alias androiddebugkey -keystore "C:\Users\Asko\.android\debug.keystore" | "C:\Users\Asko\openssl-0.9.8k_X64\bin\openssl" sha1 -binary | "C:\Users\Asko\openssl-0.9.8k_X64\bin\openssl" base64
