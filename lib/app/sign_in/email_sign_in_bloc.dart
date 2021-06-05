import 'dart:async';

import 'package:time_tracker/app/sign_in/email_sign_in_model.dart';

class EmailSignInBloc {
  //Controller
  final StreamController<EmailSignInModel> _modelController =
      StreamController<EmailSignInModel>();

  //Stream
  Stream<EmailSignInModel> get modelStream => _modelController.stream;

  //Close stream
  void dispose() {
    _modelController.close();
  }
}
