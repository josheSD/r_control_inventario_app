import 'package:shared_preferences/shared_preferences.dart';

class UserPreference {
  static final UserPreference _instancia = new UserPreference._internal();

  factory UserPreference() {
    return _instancia;
  }

  UserPreference._internal();

  late SharedPreferences _usuarioPreferencias;

  initPreferencias() async {
    this._usuarioPreferencias = await SharedPreferences.getInstance();
  }

  get token {
    return _usuarioPreferencias.getString('token') ?? '';
  }

  set setToken(String value) {
    _usuarioPreferencias.setString('token', value);
  }

  get username {
    return _usuarioPreferencias.getString('username') ?? '';
  }

  set setUsername(String value) {
    _usuarioPreferencias.setString('username', value);
  }

  void clearSharedPreferences() {
    _usuarioPreferencias.clear();
  }

  bool loggedIn() {
    return (_usuarioPreferencias.getString('token')!.isNotEmpty) ? true : false;
  }

}