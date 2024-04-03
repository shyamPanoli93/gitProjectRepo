class SignUpState {
  final SignUpStateType type;
  final String? errorMessage;

  SignUpState(this.type, {this.errorMessage});
}


enum SignUpStateType  {
  initial,
  loading,
  success,
  failure,
  invalidEmail,
  invalidPassword,
}
