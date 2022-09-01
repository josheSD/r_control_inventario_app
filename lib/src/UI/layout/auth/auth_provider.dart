import 'package:controlinventario/src/domain/auth.dart';
import 'package:controlinventario/src/infraestructure/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AuthProvider with ChangeNotifier {

  AuthService _authService = new AuthService();
  FormGroup form = FormGroup({
    'usuario':
        FormControl<String>(value: '', validators: [Validators.required]),
    'contrasenia':
        FormControl<String>(value: '', validators: [Validators.required]),
  });

  Future<bool> handlerSubmit() async {
    if (form.invalid) {
      form.markAllAsTouched();
      return false;
    }
    Auth auth = Auth.fromJson(form.value);
    return await _authService.Login(auth);
  }

}
