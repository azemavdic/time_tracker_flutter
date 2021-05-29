import 'package:flutter/material.dart';
import 'package:time_tracker/services/auth.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key, @required this.auth, @required this.onSignOut})
      : super(key: key);
  final VoidCallback onSignOut;
  final AuthBase auth;

  Future<void> _signOut() async {
    try {
      await auth.signOut();
      onSignOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Početna'),
        actions: [
          TextButton(
            onPressed: _signOut,
            child: Text(
              'Odjava',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
          )
        ],
      ),
    );
  }
}
