import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:time_tracker/app/sign_in/email_sign_in_model.dart';
import 'package:time_tracker/services/auth.dart';

class EmailSignInBloc {
  EmailSignInBloc({@required this.auth});
  final AuthBase auth;
  //Controller
  final StreamController<EmailSignInModel> _modelController =
      StreamController<EmailSignInModel>();

  //Stream
  Stream<EmailSignInModel> get modelStream => _modelController.stream;

  //Close stream
  void dispose() {
    _modelController.close();
  }

  EmailSignInModel _model = EmailSignInModel();

  //Add value to stream
  void updateWith({
    String email,
    String password,
    EmailSignInFormType formType,
    bool isLoading,
    bool submitted,
  }) {
    _model = _model.copyWith(
      email: email,
      formType: formType,
      isLoading: isLoading,
      password: password,
      submitted: submitted,
    );
    _modelController.add(_model);
  }

  Future<void> submit() async {
    updateWith(submitted: true, isLoading: true);

    try {
      if (_model.formType == EmailSignInFormType.signIn) {
        await auth.signInWithEmail(_model.email, _model.password);
      } else {
        await auth.registerWithEmail(_model.email, _model.password);
      }
    } catch (e) {
      updateWith(isLoading: true);
      rethrow;
    }
  }
}
