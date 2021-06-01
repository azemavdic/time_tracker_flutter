import 'package:flutter/material.dart';
import 'package:time_tracker/common_widgets/form_submit_button.dart';

enum EmailSignInFormType {
  signIn,
  register,
}

class EmailSignInForm extends StatefulWidget {
  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {
  bool _passwordVisible;
  FocusNode myFocusNode;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _submit() {
    print(_emailController.text);
    print(_passwordController.text);
  }

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    myFocusNode.dispose();
  }

  EmailSignInFormType _formType = EmailSignInFormType.signIn;

  void _toggleFormType() {
    setState(() {
      _formType = _formType == EmailSignInFormType.signIn
          ? EmailSignInFormType.register
          : EmailSignInFormType.signIn;

      _emailController.text = '';
      _passwordController.text = '';
    });
  }

  List<Widget> _buildChildren() {
    final primaryText =
        _formType == EmailSignInFormType.signIn ? 'Prijava' : 'Registracija';
    final secondaryText = _formType == EmailSignInFormType.signIn
        ? 'Niste registrovani? Registrujte se ovdje'
        : 'Imate račun? Prijavite se ovdje.';
    return [
      TextField(
        focusNode: myFocusNode,
        controller: _emailController,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          labelText: 'Email',
          hintText: 'test@mail.com',
        ),
      ),
      SizedBox(height: 8.0),
      TextField(
        controller: _passwordController,
        obscureText: !_passwordVisible,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
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
      FormSubmitButton(
        onPressed: _submit,
        text: primaryText,
      ),
      SizedBox(height: 8.0),
      TextButton(
        onPressed: () {
          _toggleFormType();
          myFocusNode.requestFocus();
        },
        child: Text(secondaryText),
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
