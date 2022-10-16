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

  get nombre {
    return _usuarioPreferencias.getString('nombre') ?? '';
  }

  set setNombre(String value) {
    _usuarioPreferencias.setString('nombre', value);
  }

  get usuario {
    return _usuarioPreferencias.getString('usuario') ?? '';
  }

  set setUsuario(String value) {
    _usuarioPreferencias.setString('usuario', value);
  }

  get rol {
    return _usuarioPreferencias.getString('rol') ?? '';
  }

  set setRol(String value) {
    _usuarioPreferencias.setString('rol', value);
  }

  get direccion {
    return _usuarioPreferencias.getString('direccion') ?? '';
  }

  set setDireccion(String value) {
    _usuarioPreferencias.setString('direccion', value);
  }

  void clearSharedPreferences() {
    _usuarioPreferencias.clear();
  }

  bool loggedIn() {
    return (_usuarioPreferencias.getString('token')!.isNotEmpty) ? true : false;
  }

}