import 'package:controlinventario/src/UI/layout/auth/auth_provider.dart';
import 'package:controlinventario/src/core/components/input.dart';
import 'package:controlinventario/src/core/util/constantes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AuthPage extends StatefulWidget {
  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Envinronment.colorBackground,
      body: SafeArea(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ReactiveForm(
                    formGroup: authProvider.form,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 25.0),
                        _logoTipo(),
                        SizedBox(height: 30.0),
                        Input.control(
                            formControlName: 'usuario',
                            labelText: 'Usuario',
                            errorText: 'Ingresa usuario',
                            isContrasenia: false,
                            type: Envinronment.controlCorreo),
                        SizedBox(height: 18.0),
                        Input.control(
                            formControlName: 'contrasenia',
                            labelText: 'Contraseña',
                            errorText: 'Ingresa contraseña',
                            isContrasenia: true,
                            type: Envinronment.controlText),
                        SizedBox(height: 15.0),
                        _buttonSubmit(authProvider, context)
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  Widget _buttonSubmit(AuthProvider authProvider, BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(40),
        primary: Envinronment.colorSecond,
      ),
      child: Text('Iniciar Sesión'),
      onPressed: () => {_onPressed(authProvider, context)},
    );
  }

  _onPressed(AuthProvider authProvider, BuildContext context) async {
    await authProvider.handlerSubmit(context);
  }

  _logoTipo() {
    return Image.asset('imagenes/logo.jpeg', height: 122, width: 188);
  }
}
