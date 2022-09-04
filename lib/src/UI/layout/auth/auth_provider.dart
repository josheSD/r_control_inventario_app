import 'package:controlinventario/src/core/interfaces/response.dart';
import 'package:controlinventario/src/domain/auth.dart';
import 'package:controlinventario/src/domain/user.dart';
import 'package:controlinventario/src/infraestructure/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

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
    // Auth auth = Auth.fromJson(form.value);
    // Response<Usuario> response = await _authService.Login(auth);
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


    this.form.reset(removeFocus: true);
    Navigator.pushNamed(context, 'portal');
  }
}
