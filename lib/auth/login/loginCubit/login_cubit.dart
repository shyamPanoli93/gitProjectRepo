import 'package:firebase_auth/firebase_auth.dart';
import 'package:bloc/bloc.dart';

import '../../../utils/shared_preference.dart';
import '../state/login_state_enum.dart';

class LoginCubit extends Cubit<AuthState?> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  LoginCubit() : super(null);

  bool _isValidEmail(String email) {
    // Validate email using regex or other validation logic
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  bool _isValidPassword(String password) {
    // Validate password length or other validation logic
    return password.length >= 6;
  }

  void login(String email, String password) async {
    // Validate email and password
    if (!_isValidEmail(email)) {
      emit(AuthState(AuthStateType.invalidEmail));
      return;
    }

    if (!_isValidPassword(password)) {
      emit(AuthState(AuthStateType.invalidPassword));
      return;
    }

    emit(AuthState(AuthStateType.loading));
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      SharedPreference().setBooleanValue(SharedPrefKeys.isLogged, true);
      emit(AuthState(AuthStateType.success));
    } on FirebaseAuthException catch (e) {
      emit(AuthState(AuthStateType.failure, errorMessage: '${e.message}'));
    } catch (_) {
      emit(AuthState(AuthStateType.failure));
    }
  }
}
