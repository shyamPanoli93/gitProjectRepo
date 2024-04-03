class AuthState {
  final AuthStateType type;
  final String? errorMessage;

  AuthState(this.type, {this.errorMessage});
}


enum AuthStateType  {
  initial,
  loading,
  success,
  failure,
  invalidEmail,
  invalidPassword,
}
