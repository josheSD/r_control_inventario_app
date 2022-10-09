import 'package:controlinventario/src/domain/auth.dart';
import 'package:controlinventario/src/infraestructure/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../core/shared-preferences/user.preference.dart';

class AuthProvider with ChangeNotifier {
  AuthService _authService = new AuthService();
  FormGroup form = new FormGroup({
    'usuario':
        FormControl<String>(value: '', validators: [Validators.required]),
    'contrasenia':
        FormControl<String>(value: '', validators: [Validators.required]),
  });

  Future<void> handlerSubmit(BuildContext context) async {
    if (form.invalid) {
      form.markAllAsTouched();
      return;
    }
    
    final auth = Auth.fromJson(form.value);
    final response = await _authService.login(auth);

    final userPreference = new UserPreference();
    userPreference.setUsername = response.data.nombre;
    userPreference.setToken = response.data.token;

    Navigator.pushNamed(context, 'portal');

    // Auth auth = Auth.fromJson(form.value);
    // Response<Usuario> response = await _authService.login(auth);
    // if (response.status) {
    //   this.form.reset(removeFocus: true);

    //   SnackBar snackBar = SnackBar(
    //       content: Text('Exito',
    //           style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
    //       duration: Duration(seconds: 3),
    //       backgroundColor: Colors.green);
    //   Scaffold.of(context).showSnackBar(snackBar);

    //   Navigator.pushNamed(context, 'portal');
    // } else {
    //   SnackBar snackBar = SnackBar(
    //       content: Text('Error al crear',
    //           style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
    //       duration: Duration(seconds: 3),
    //       backgroundColor: Colors.red);
    //   Scaffold.of(context).showSnackBar(snackBar);
    // }


  }

  cleanForm(){
    form.reset(removeFocus: true);
  }

}
