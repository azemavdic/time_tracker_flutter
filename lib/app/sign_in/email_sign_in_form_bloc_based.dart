import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/app/sign_in/email_sign_in_bloc.dart';
import 'package:time_tracker/app/sign_in/validators.dart';
import 'package:time_tracker/common_widgets/form_submit_button.dart';
import 'package:time_tracker/common_widgets/show_exception_alert_dialog.dart';
import 'package:time_tracker/services/auth.dart';

import 'email_sign_in_model.dart';

class EmailSignInFormBlocBased extends StatefulWidget
    with EmailAndPasswordValidators {
  EmailSignInFormBlocBased({@required this.bloc});
  final EmailSignInBloc bloc;
  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return Provider<EmailSignInBloc>(
      create: (_) => EmailSignInBloc(auth: auth),
      child: Consumer<EmailSignInBloc>(
        builder: (_, bloc, __) => EmailSignInFormBlocBased(bloc: bloc),
      ),
      dispose: (_, bloc) => bloc.dispose(),
    );
  }

  @override
  _EmailSignInFormBlocBasedState createState() =>
      _EmailSignInFormBlocBasedState();
}

class _EmailSignInFormBlocBasedState extends State<EmailSignInFormBlocBased> {
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

  void _toggleFormType(EmailSignInModel model) {
    widget.bloc.updateWith(
      email: '',
      password: '',
      isLoading: false,
      submitted: false,
      formType: model.formType == EmailSignInFormType.signIn
          ? EmailSignInFormType.register
          : EmailSignInFormType.signIn,
    );

    _emailController.text = '';
    _passwordController.text = '';
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _submit() async {
    try {
      await widget.bloc.submit();
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      print(e.code);
      showExceptionAlertDialog(
        context,
        title: 'Neuspješna prijava',
        exception: e,
      );
    }
  }

  void _emailEditingComplete(EmailSignInModel model) {
    final newFocus = widget.emailValidator.isValid(model.email)
        ? _emailFocusNode
        : _passwordFocusNode;
    newFocus.requestFocus();
  }

  List<Widget> _buildChildren(EmailSignInModel model) {
    final primaryText = model.formType == EmailSignInFormType.signIn
        ? 'Prijava'
        : 'Registracija';
    final secondaryText = model.formType == EmailSignInFormType.signIn
        ? 'Niste registrovani? Registrujte se ovdje'
        : 'Imate račun? Prijavite se ovdje.';

    bool submitEnabled = widget.emailValidator.isValid(model.email) &&
        widget.emailValidator.isValid(model.password) &&
        !model.isLoading;

    return [
      _buildEmailTextField(model),
      SizedBox(height: 8.0),
      _buildPasswordTextField(model),
      SizedBox(height: 8.0),
      FormSubmitButton(
        onPressed: submitEnabled ? _submit : null,
        text: primaryText,
      ),
      SizedBox(height: 8.0),
      TextButton(
        onPressed: !model.isLoading ? () => _toggleFormType(model) : null,
        child: Text(secondaryText),
      )
    ];
  }

  //Widget za unos šifre
  TextField _buildPasswordTextField(EmailSignInModel model) {
    bool showErrorText =
        model.submitted && !widget.passwordValidator.isValid(model.password);
    return TextField(
      onChanged: (password) => widget.bloc.updateWith(password: password),
      onEditingComplete: _submit,
      textInputAction: TextInputAction.done,
      focusNode: _passwordFocusNode,
      controller: _passwordController,
      obscureText: !_passwordVisible,
      decoration: InputDecoration(
        enabled: model.isLoading == false,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
        errorText: showErrorText ? widget.invalidPasswordText : null,
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

  //Widget za unos emaila
  TextField _buildEmailTextField(EmailSignInModel model) {
    bool showErrorText =
        model.submitted && !widget.emailValidator.isValid(model.email);
    return TextField(
      onChanged: (email) => widget.bloc.updateWith(email: email),
      onEditingComplete: () => _emailEditingComplete(model),
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      textInputAction: TextInputAction.next,
      focusNode: _emailFocusNode,
      controller: _emailController,
      decoration: InputDecoration(
        enabled: model.isLoading == false,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
        labelText: 'Email',
        hintText: 'test@mail.com',
        errorText: showErrorText ? widget.invalidEmailText : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<EmailSignInModel>(
        stream: widget.bloc.modelStream,
        initialData: EmailSignInModel(),
        builder: (context, snapshot) {
          final EmailSignInModel model = snapshot.data;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: _buildChildren(model),
            ),
          );
        });
  }
}
