import 'package:flutter_riverpod/legacy.dart';

class AuthState {
  final bool isLoading;
  final String? error;
  final bool isAuthenticated;

  AuthState({this.isLoading = false, this.error, this.isAuthenticated = false});
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState());

  Future<void> login(String email, String password) async {
    state = AuthState(isLoading: true);
    await Future.delayed(const Duration(seconds: 1));

    // Admin credentials
    if (email == 'admin@serviko.com' && password == 'admin123') {
      state = AuthState(isAuthenticated: true);
    } else {
      state = AuthState(error: 'Invalid admin credentials');
    }
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(),
);
