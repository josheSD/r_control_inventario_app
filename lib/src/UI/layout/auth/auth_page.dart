import 'package:controlinventario/src/UI/layout/auth/auth_provider.dart';
import 'package:controlinventario/src/core/components/input.dart';
import 'package:controlinventario/src/core/util/constantes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:loader_overlay/loader_overlay.dart';

class AuthPage extends StatefulWidget {
  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late AuthProvider authProvider;
  bool _procesandoLoading = false;

  @override
  Widget build(BuildContext context) {
    authProvider = Provider.of<AuthProvider>(context, listen: false);

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
                        SizedBox(height: 15.0),
                        Input.control(
                            formControlName: 'contrasenia',
                            labelText: 'Contraseña',
                            errorText: 'Ingresa contraseña',
                            isContrasenia: true,
                            type: Envinronment.controlText),
                        SizedBox(height: 30.0),
                        _buttonSubmit(context)
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  Widget _buttonSubmit(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(40),
        backgroundColor: Envinronment.colorButton,
        shape: StadiumBorder(),
        elevation: 0,
      ),
      child: Container(
          child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(left: 5),
            child: Text('Iniciar Sesión',
                style: TextStyle(
                    color: Envinronment.colorBlack,
                    fontWeight: FontWeight.normal)),
          ),
          _procesandoLoading
              ? Container(
                  margin: EdgeInsets.only(left: 12),
                  child: SizedBox(
                    child: CircularProgressIndicator(
                        color: Envinronment.colorWhite),
                    height: 16.0,
                    width: 16.0,
                  ),
                )
              : Container()
        ],
      )),
      onPressed: _procesandoLoading ? null : () => {_onPressed(context)},
    );
  }

  _onPressed(BuildContext context) async {
    context.loaderOverlay.show();
    await authProvider.handlerSubmit(context);
    context.loaderOverlay.hide();
  }

  _logoTipo() {
    return Image.asset('imagenes/logo.jpeg', height: 122, width: 188);
  }
}
