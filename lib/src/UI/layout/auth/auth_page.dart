import 'package:controlinventario/src/UI/layout/auth/auth_provider.dart';
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
                        _inputForm(
                            'usuario', 'Usuario', 'Ingresa usuario', false),
                        SizedBox(height: 18.0),
                        _inputForm('contrasenia', 'Contraseña',
                            'Ingresa contraseña', true),
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

  Widget _inputForm(String formControlName, String labelText, String errorText,
      bool isContrasenia) {
    return ReactiveTextField(
      formControlName: formControlName,
      textInputAction: TextInputAction.next,
      validationMessages: {ValidationMessage.required: (error) => errorText},
      obscureText: isContrasenia,
      cursorColor: Envinronment.colorPrimary,
      style: TextStyle(
          color: Envinronment.colorPrimary,
          decorationColor: Envinronment.colorPrimary),
      decoration: InputDecoration(
          labelText: labelText,
          labelStyle: new TextStyle(color: Envinronment.colorPrimary),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Envinronment.colorDanger),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Envinronment.colorPrimary),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Envinronment.colorDanger),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Envinronment.colorPrimary),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Envinronment.colorPrimary),
          )),
    );
  }

  Widget _buttonSubmit(AuthProvider authProvider, BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(40),
          primary: Envinronment.colorSecond,),
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
