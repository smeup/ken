class AuthenticationModel {
  bool managed;
  Function logoutFunction;

  AuthenticationModel({this.managed = false, this.logoutFunction});
}
