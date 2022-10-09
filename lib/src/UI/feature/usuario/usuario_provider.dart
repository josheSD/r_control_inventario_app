import 'package:controlinventario/src/core/interfaces/response-usuario.dart';
import 'package:controlinventario/src/core/util/routes.dart';
import 'package:controlinventario/src/domain/usuario.dart';
import 'package:controlinventario/src/infraestructure/usuario_service.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../core/interfaces/response-rol.dart';

class UsuarioProvider with ChangeNotifier {
  UsuarioService _usuarioService = new UsuarioService();

  FormGroup form = new FormGroup({
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

    Navigator.pushNamed(context, Routes.USUARIO);
  }

  void initializeForm(Usuario usuario) {
    final value = {
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

  Future<ResponseUsuario> postUsuario(Usuario usuario) async {
    ResponseUsuario response = await _usuarioService.postUsuario(usuario);
    return response;
  }

  Future<ResponseUsuario> putUsuario(Usuario usuario) async {
    ResponseUsuario response = await _usuarioService.putUsuario(usuario);
    return response;
  }

  Future<ResponseUsuario> deleteUsuario(int idProyecto) async {
    ResponseUsuario response = await _usuarioService.deleteUsuario(idProyecto);
    return response;
  }
}
