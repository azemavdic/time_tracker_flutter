import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:time_tracker/services/auth.dart';

class SignInBloc {
  SignInBloc({@required this.auth});
  final AuthBase auth;
  // Controller
  final StreamController<bool> _isLoadingController = StreamController<bool>();

  //1. Stream
  Stream<bool> get isLoadingStream => _isLoadingController.stream;

  //2. Close a stream
  void dispose() {
    _isLoadingController.close();
  }

  //3.Add value to stream
  void _setIsLoading(bool isLoading) => _isLoadingController.add(isLoading);

  //Sign in methods
  Future<User> _signIn(Future<User> Function() signInMethod) async {
    try {
      _setIsLoading(true);
      return await signInMethod();
    } catch (e) {
      _setIsLoading(false);
      rethrow;
    }
  }

  Future<User> signInAnonymously() async =>
      await _signIn(auth.signInAnonymously);

  Future<User> signInWithGoogle() async => await _signIn(auth.signInWithGoogle);
  Future<User> signInWithFacebook() async =>
      await _signIn(auth.signInWithFacebook);
}
