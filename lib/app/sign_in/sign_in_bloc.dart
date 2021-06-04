import 'dart:async';

class SignInBloc {
  // Controller
  final StreamController<bool> _isLoadingController = StreamController<bool>();

  //1. Stream
  Stream<bool> get isLoadingStream => _isLoadingController.stream;

  //2. Close a stream
  void dispose() {
    _isLoadingController.close();
  }

  //3.Add value to stream
  void setIsLoading(bool isLoading) => _isLoadingController.add(isLoading);
}
