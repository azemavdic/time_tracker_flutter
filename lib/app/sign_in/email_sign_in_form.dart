import 'package:flutter/material.dart';
import 'package:time_tracker/app/sign_in/validators.dart';
import 'package:time_tracker/common_widgets/form_submit_button.dart';
import 'package:time_tracker/services/auth.dart';

enum EmailSignInFormType {
  signIn,
  register,
}

class EmailSignInForm extends StatefulWidget with EmailAndPasswordValidators {
  EmailSignInForm({@required this.auth});
  final AuthBase auth;
  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {
  bool _passwordVisible;
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
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

  String get _email => _emailController.text;
  String get _password => _passwordController.text;

  void _submit() async {
    try {
      if (_formType == EmailSignInFormType.signIn) {
        await widget.auth.signInWithEmail(_email, _password);
      } else {
        await widget.auth.registerWithEmail(_email, _password);
      }
      Navigator.of(context).pop();
    } catch (e) {
      print(e.toString());
    }
  }

  void _emailEditingComplete() {
    _passwordFocusNode.requestFocus();
  }

  List<Widget> _buildChildren() {
    final primaryText =
        _formType == EmailSignInFormType.signIn ? 'Prijava' : 'Registracija';
    final secondaryText = _formType == EmailSignInFormType.signIn
        ? 'Niste registrovani? Registrujte se ovdje'
        : 'Imate račun? Prijavite se ovdje.';

    bool submitEnabled = widget.emailValidator.isValid(_email) &&
        widget.emailValidator.isValid(_password);

    return [
      _buildEmailTextField(),
      SizedBox(height: 8.0),
      _buildPasswordTextField(),
      SizedBox(height: 8.0),
      FormSubmitButton(
        onPressed: submitEnabled ? _submit : null,
        text: primaryText,
      ),
      SizedBox(height: 8.0),
      TextButton(
        onPressed: () {
          _toggleFormType();
          _emailFocusNode.requestFocus();
        },
        child: Text(secondaryText),
      )
    ];
  }

  //Widget za unos šifre
  TextField _buildPasswordTextField() {
    return TextField(
      onChanged: (password) => _updateState(),
      onEditingComplete: _submit,
      textInputAction: TextInputAction.done,
      focusNode: _passwordFocusNode,
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
    );
  }

  void _updateState() {
    setState(() {});
  }

  //Widget za unos emaila
  TextField _buildEmailTextField() {
    return TextField(
      onChanged: (password) => _updateState(),
      onEditingComplete: _emailEditingComplete,
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      textInputAction: TextInputAction.next,
      focusNode: _emailFocusNode,
      controller: _emailController,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
        labelText: 'Email',
        hintText: 'test@mail.com',
      ),
    );
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
