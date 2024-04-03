import 'package:firebase_auth/firebase_auth.dart';
import 'package:bloc/bloc.dart';
import 'package:product_management/auth/signUp/state/signUpState.dart';

import '../../../utils/shared_preference.dart';

class SignUpCubit extends Cubit<SignUpState?> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  SignUpCubit() : super(null);

  bool _isValidEmail(String email) {
    // Validate email using regex or other validation logic
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  bool _isValidPassword(String password) {
    // Validate password length or other validation logic
    return password.length >= 6;
  }


  void signUp(String email, String password) async {
    // Validate email and password
    if (!_isValidEmail(email)) {
      emit(SignUpState(SignUpStateType.invalidEmail));
      return;
    }

    if (!_isValidPassword(password)) {
      emit(SignUpState(SignUpStateType.invalidPassword));
      return;
    }

    emit(SignUpState(SignUpStateType.loading));
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      SharedPreference().setBooleanValue(SharedPrefKeys.isLogged, true);
      emit(SignUpState(SignUpStateType.success));
    } on FirebaseAuthException catch (e) {
      emit(SignUpState(SignUpStateType.failure, errorMessage: '${e.message}'));
    } catch (_) {
      emit(SignUpState(SignUpStateType.failure));
    }
  }
}
