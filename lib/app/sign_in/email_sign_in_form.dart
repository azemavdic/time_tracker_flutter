import 'package:flutter/material.dart';

class EmailSignInForm extends StatefulWidget {
  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {
  bool _passwordVisible;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  List<Widget> _buildChildren() {
    return [
      TextField(
        decoration: InputDecoration(
          labelText: 'Email',
          hintText: 'test@mail.com',
        ),
      ),
      SizedBox(height: 8.0),
      TextField(
        obscureText: !_passwordVisible,
        decoration: InputDecoration(
          labelText: 'Šifra',
          suffixIcon: IconButton(
              color: Colors.grey,
              icon: !_passwordVisible
                  ? Icon(Icons.visibility)
                  : Icon(Icons.visibility_off),
              onPressed: () {
                setState(() {
                  _passwordVisible = !_passwordVisible;
                });
              }),
        ),
      ),
      SizedBox(height: 8.0),
      ElevatedButton(
        onPressed: () {},
        child: Text('Prijava'),
      ),
      SizedBox(height: 8.0),
      TextButton(
        onPressed: () {},
        child: Text('Niste registrovani? Registrujte se ovdje.'),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: _buildChildren(),
      ),
    );
  }
}
