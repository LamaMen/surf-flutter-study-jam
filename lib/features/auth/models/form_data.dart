class FormData {
  final String login;
  final String password;

  const FormData(this.login, this.password);

  const FormData.empty() : this('', '');

  FormData clearPassword() {
    return FormData(login, '');
  }

  bool get isEmpty => login.isEmpty || password.isEmpty;
}
