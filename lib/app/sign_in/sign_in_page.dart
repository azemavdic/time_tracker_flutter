import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/app/sign_in/email_sign_in_page.dart';
import 'package:time_tracker/app/sign_in/sign_in_bloc.dart';
import 'package:time_tracker/app/sign_in/sign_in_button.dart';
import 'package:time_tracker/app/sign_in/social_sign_in_button.dart';
import 'package:time_tracker/common_widgets/show_exception_alert_dialog.dart';
import 'package:time_tracker/services/auth.dart';

class SignInPage extends StatelessWidget {
  static Widget create(BuildContext context) {
    return Provider<SignInBloc>(
      create: (_) => SignInBloc(),
      child: SignInPage(),
    );
  }

  void _showSignInError(BuildContext context, Exception exception) {
    showExceptionAlertDialog(
      context,
      title: 'Neuspjela prijava',
      exception: exception,
    );
  }

  Future<void> _signInAnonimosly(BuildContext context) async {
    final bloc = Provider.of<SignInBloc>(context, listen: false);
    try {
      bloc.setIsLoading(true);
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signInAnonymously();
    } on Exception catch (e) {
      _showSignInError(context, e);
    } finally {
      bloc.setIsLoading(false);
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    final bloc = Provider.of<SignInBloc>(context, listen: false);
    try {
      bloc.setIsLoading(true);
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signInWithGoogle();
    } on Exception catch (e) {
      _showSignInError(context, e);
    } finally {
      bloc.setIsLoading(false);
    }
  }

  Future<void> _signInWithFacebook(BuildContext context) async {
    final bloc = Provider.of<SignInBloc>(context, listen: false);
    try {
      bloc.setIsLoading(true);
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signInWithFacebook();
    } on Exception catch (e) {
      _showSignInError(context, e);
    } finally {
      bloc.setIsLoading(false);
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
    final bloc = Provider.of<SignInBloc>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Tracker'),
        elevation: 5.0,
      ),
      body: StreamBuilder<bool>(
          stream: bloc.isLoadingStream,
          initialData: false,
          builder: (context, snapshot) {
            return _buildContent(context, snapshot.data);
          }),
      backgroundColor: Colors.grey.shade200,
    );
  }

  Widget _buildContent(context, bool isLoading) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildHeader(isLoading),
          SizedBox(
            height: 48.0,
          ),
          SocialSignInButton(
            backgroundColor: Color(0xFF334D92),
            socialImage: 'facebook',
            onPressed: isLoading ? null : () => _signInWithFacebook(context),
            text: 'Prijava putem Facebook-a',
            textColor: Colors.white,
          ),
          SizedBox(
            height: 8.0,
          ),
          SocialSignInButton(
            backgroundColor: Colors.white,
            socialImage: 'google',
            onPressed: isLoading ? null : () => _signInWithGoogle(context),
            text: 'Prijava putem Google-a',
            textColor: Colors.black87,
          ),
          SizedBox(height: 8.0),
          SignInButton(
            icon: Icons.mail,
            text: 'Prijava putem Email-a',
            textColor: Colors.white,
            backgroundColor: Colors.teal.shade700,
            onPressed: isLoading ? null : () => _signInWithEmail(context),
          ),
          SizedBox(height: 16.0),
          Row(
            children: [
              Expanded(
                child: Divider(
                  thickness: 1.0,
                ),
              ),
              Text(
                'ili',
                textAlign: TextAlign.center,
              ),
              Expanded(
                child: Divider(
                  thickness: 1.0,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          SignInButton(
            icon: Icons.account_circle,
            text: 'Anonimna prijava',
            textColor: Colors.black87,
            backgroundColor: Colors.lime.shade400,
            onPressed: isLoading ? null : () => _signInAnonimosly(context),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(bool isLoading) {
    if (isLoading == true) {
      return LinearProgressIndicator();
    }
    return Text(
      'Prijavi se',
      style: TextStyle(
        fontSize: 30.0,
        fontWeight: FontWeight.w600,
      ),
      textAlign: TextAlign.center,
    );
  }
}
