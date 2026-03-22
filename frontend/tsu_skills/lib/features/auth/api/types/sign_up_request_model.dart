// Deprecated — auth now goes through AuthDatasource directly
class SignUpRequestModel {
  final String name;
  final String email;
  final String password;
  const SignUpRequestModel({required this.name, required this.email, required this.password});
}
