import 'package:controlinventario/src/core/util/constantes.dart';
import 'package:controlinventario/src/domain/auth.dart';
import 'package:controlinventario/src/infraestructure/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../core/interfaces/response-login.dart';
import '../../../core/shared-preferences/user.preference.dart';

class AuthProvider with ChangeNotifier {
  AuthService _authService = new AuthService();
  FormGroup form = new FormGroup({
    'usuario': FormControl<String>(
        value: 'jchutas@gmail.com', validators: [Validators.required]),
    'contrasenia': FormControl<String>(
        value: '123', validators: [Validators.required]),
  });

  Future<void> handlerSubmit(BuildContext context) async {
    if (form.invalid) {
      form.markAllAsTouched();
      return;
    }

    Auth auth = Auth.fromJson(form.value);
    ResponseLogin response = await _authService.login(auth);

    if (response.status) {
      this.form.reset(removeFocus: true);

      final userPreference = new UserPreference();
      userPreference.setUsuario = response.data!.usuario;
      userPreference.setNombre = response.data!.nombre;
      userPreference.setDireccion = response.data!.direccion;
      userPreference.setToken = response.data!.token;
      userPreference.setRol = response.data!.rol;

      SnackBar snackBar = SnackBar(
          content: Text(response.message,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
          duration: Duration(seconds: 3),
          backgroundColor: Envinronment.colorSecond);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          snackBar,
        );
      });

      Navigator.pushNamed(context, 'portal');

    } else {

      SnackBar snackBar = SnackBar(
          content: Text(response.message,
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Envinronment.colorWhite)),
          duration: Duration(seconds: 3),
          backgroundColor: Envinronment.colorDanger);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          snackBar,
        );
      });

    }
  }

  cleanForm() {
    form.reset(removeFocus: true);
  }
}
