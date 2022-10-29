import 'package:controlinventario/src/core/interfaces/response-usuario.dart';
import 'package:controlinventario/src/core/util/constantes.dart';
import 'package:controlinventario/src/core/util/routes.dart';
import 'package:controlinventario/src/domain/usuario.dart';
import 'package:controlinventario/src/infraestructure/usuario_service.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../core/interfaces/response-rol.dart';

class UsuarioProvider with ChangeNotifier {
  UsuarioService _usuarioService = new UsuarioService();

  FormGroup form = new FormGroup({
    'id': FormControl<String>(value: ''),
    'nombre': FormControl<String>(value: '', validators: [Validators.required]),
    'direccion':
        FormControl<String>(value: '', validators: [Validators.required]),
    'usuario':
        FormControl<String>(value: '', validators: [Validators.required]),
    'contrasenia':
        FormControl<String>(value: '', validators: [Validators.required]),
    'repetirContrasenia':
        FormControl<String>(value: '', validators: [Validators.required]),
    'idRol': FormControl<String>(value: '', validators: [Validators.required]),
  });

  Future<void> handleSubmit(BuildContext context) async {
    if (form.invalid) {
      form.markAllAsTouched();
      return;
    }

    var usuarioMap = form.value;
    if (usuarioMap["contrasenia"] != usuarioMap["repetirContrasenia"]) {
      SnackBar snackBar = SnackBar(
          content: Text("Contraseña y Repetir Contraseña son diferentes",
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

      return;
    }

    late ResponseUsuario response;
    if (form.value["id"].toString().length > 0 &&
        form.value["id"].toString() != 'null') {
      response = await _usuarioService.putUsuario(form.value);
    } else {
      response = await _usuarioService.postUsuario(form.value);
    }

    if (response.status) {
      this.form.reset(removeFocus: true);

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

      Navigator.pushReplacementNamed(context, Routes.USUARIO);
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

  void initializeForm(Usuario usuario) {
    final value = {
      'id': usuario.id.toString(),
      'nombre': usuario.nombre,
      'direccion': usuario.direccion,
      'usuario': usuario.usuario,
      'contrasenia': '',
      'repetirContrasenia': '',
      'idRol': usuario.rol.id.toString(),
    };
    form.patchValue(value);
  }

  void cleanForm() {
    form.reset(removeFocus: true);
  }

  Future<ResponseRol> getRoles() async {
    ResponseRol response = await _usuarioService.getRoles();
    return response;
  }

  Future<ResponseUsuario> getUsuarios() async {
    ResponseUsuario response = await _usuarioService.getUsuarios();
    return response;
  }

  Future<ResponseUsuario> deleteUsuario(int idProyecto) async {
    ResponseUsuario response = await _usuarioService.deleteUsuario(idProyecto);
    return response;
  }
}
