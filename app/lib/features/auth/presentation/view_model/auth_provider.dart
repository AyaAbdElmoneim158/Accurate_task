import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart';
import '../../data/models/login_request.dart';
import '../../data/models/login_response.dart';
import '../../data/repo/auth_repo.dart';

enum AuthStatus {
  initial,
  loading,
  authenticated,
  error,
}

class AuthProvider with ChangeNotifier {
  String? _token;
  AuthStatus _authStatus = AuthStatus.initial;
  String? _errorMessage = "";
  final AuthRepo _authRepo;

  AuthProvider(this._authRepo);

  String? get token => _token;
  AuthStatus get authStatus => _authStatus;
  String? get errorMessage => _errorMessage; // Getter for the error message

  void login(LoginRequest loginRequest) async {
    _authStatus = AuthStatus.loading;
    notifyListeners();

    // Call the login method from AuthRepo
    final Either<String, LoginResponse> response =
        await _authRepo.login(loginRequest);

    response.fold(
      (failure) {
        // Handle failure case
        _authStatus = AuthStatus.error;
        _errorMessage = failure; // Store the error message
        notifyListeners(); // Notify listeners to update the UI

        // Optionally, you can show a snack bar here or handle it in the UI
      },
      (loginResponse) {
        // Handle success case
        _token = loginResponse.token;
        _authStatus = AuthStatus.authenticated;
        _errorMessage = null; // Clear the error message on success
        notifyListeners();
      },
    );
  }

  void authenticated() {
    if (_authRepo.authenticated()) {
      _authStatus = AuthStatus.authenticated;
      debugPrint("authenticated at AuthProvider");
      notifyListeners();
    }
  }
}
