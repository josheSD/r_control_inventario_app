import 'package:controlinventario/src/UI/layout/auth/auth_provider.dart';
import 'package:controlinventario/src/core/util/constantes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      body: SafeArea(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                Text('HOla'),
                ReactiveForm(
                  formGroup: authProvider.form,
                  child: Column(
                    children: <Widget>[
                      _inputForm(
                          'usuario', 'Usuario', 'Ingresa usuario', false),
                      _inputForm('contrasenia', 'Contraseña',
                          'Ingresa contraseña', true),
                      _buttonSubmit(authProvider, context)
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget _inputForm(String formControlName, String labelText, String errorText,
      bool isContrasenia) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: ReactiveTextField(
        formControlName: formControlName,
        validationMessages: {ValidationMessage.required: (error) => errorText},
        obscureText: isContrasenia,
        cursorColor: Envinronment.colorPrimary,
        style: TextStyle(
            color: Envinronment.colorPrimary,
            decorationColor: Envinronment.colorPrimary),
        decoration: InputDecoration(
            labelText: labelText,
            labelStyle: new TextStyle(color: Envinronment.colorPrimary),
            counterStyle: TextStyle(
                color: Envinronment.colorSecond,
                decorationColor: Envinronment.colorSecond),
            icon:
                Icon(Icons.perm_contact_cal, color: Envinronment.colorPrimary),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Envinronment.colorPrimary),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Envinronment.colorPrimary),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Envinronment.colorPrimary),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Envinronment.colorPrimary),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Envinronment.colorPrimary),
            )),
      ),
    );
  }

  Widget _buttonSubmit(AuthProvider authProvider, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: ElevatedButton(
        child: Text('Iniciar Sesión'),
        onPressed: () => {_onPressed(authProvider, context)},
      ),
    );
  }

  _onPressed(AuthProvider authProvider, BuildContext context) async {
    try {
      bool isLogged = await authProvider.handlerSubmit();
      authProvider.form.reset(removeFocus: true);
      Navigator.pushNamed(context, 'portal');
    } catch (ex) {
      print(ex);
    }
  }
}
