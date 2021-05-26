import 'package:flutter/material.dart';
import 'package:time_tracker/app/common_widgets/custom_elevated_button.dart';
import 'package:time_tracker/app/sign_in/sign_in_button.dart';

class SignInPage extends StatelessWidget {
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
            height: 8.0,
          ),
          SignInButton(
            text: 'Prijava putem Facebooka',
            textColor: Colors.white,
            backgroundColor: Colors.blue.shade700,
            onPressed: () {},
          ),
          SizedBox(
            height: 8.0,
          ),
          CustomElevatedButton(
            child: Text(
              'Prijava putem Googla',
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.white,
            onPressed: () {},
          ),
          SizedBox(height: 8.0),
          CustomElevatedButton(
            child: Text(
              'Prijava putem Emaila',
            ),
            backgroundColor: Colors.green,
            onPressed: () {},
          ),
          SizedBox(height: 8.0),
          Text(
            'ili',
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.0),
          CustomElevatedButton(
            child: Text(
              'Anonimna prijava',
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.orange,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
