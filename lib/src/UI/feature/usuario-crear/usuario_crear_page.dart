import 'package:controlinventario/src/UI/feature/usuario/usuario_provider.dart';
import 'package:controlinventario/src/core/components/input.dart';
import 'package:controlinventario/src/core/interfaces/response-rol.dart';
import 'package:controlinventario/src/core/util/constantes.dart';
import 'package:controlinventario/src/domain/rol.dart';
import 'package:controlinventario/src/domain/usuario.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../core/util/routes.dart';

class UsuarioCrearPage extends StatefulWidget {
  @override
  State<UsuarioCrearPage> createState() => _UsuarioCrearPageState();
}

class _UsuarioCrearPageState extends State<UsuarioCrearPage> {
  bool _procesandoLoading = false;
  bool _isCreate = true;
  late UsuarioProvider usuarioProvider;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    usuarioProvider.cleanForm();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    usuarioProvider = Provider.of<UsuarioProvider>(context, listen: false);

    final argument = (ModalRoute.of(context)!.settings.arguments);
    if (argument != null) {
      usuarioProvider.initializeForm(argument as Usuario);
      _isCreate = false;
    }

    return Scaffold(
      backgroundColor: Envinronment.colorBackground,
      appBar: AppBar(
        title: Text('Usuario',
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18)),
        centerTitle: true,
        backgroundColor: Envinronment.colorBackground,
        titleTextStyle: TextStyle(color: Envinronment.colorBlack),
        elevation: 0,
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(FontAwesomeIcons.chevronLeft),
            color: Envinronment.colorPrimary,
            onPressed: () {
                Navigator.pushReplacementNamed(context,Routes.USUARIO);
            },
          );
        }),
      ),
      body: SafeArea(
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: FutureBuilder(
                  future: usuarioProvider.getRoles(),
                  builder: (BuildContext context,
                      AsyncSnapshot<ResponseRol> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.status) {
                        List<Rol> roles = snapshot.data!.data;

                        return _buildBody(roles, context);
                      } else {
                        return Container();
                      }
                    } else {
                      return Center(
                          child: CircularProgressIndicator(
                              color: Envinronment.colorSecond));
                    }
                  }))),
    );
  }

  Widget _buildBody(List<Rol> roles, BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ReactiveForm(
              formGroup: usuarioProvider.form,
              child: Column(
                children: [
                  SizedBox(
                    height: 22.0,
                  ),
                  Input.control(
                      formControlName: 'nombre',
                      labelText: 'Nombre',
                      errorText: 'Ingrese Nombre',
                      isContrasenia: false,
                      type: Envinronment.controlText),
                  SizedBox(height: 18.0),
                  Input.control(
                      formControlName: 'direccion',
                      labelText: 'Dirección',
                      errorText: 'Ingrese Dirección',
                      isContrasenia: false,
                      type: Envinronment.controlText),
                  SizedBox(height: 18.0),
                  Input.control(
                      formControlName: 'usuario',
                      labelText: 'Usuario',
                      errorText: 'Ingrese Usuario',
                      isContrasenia: false,
                      type: Envinronment.controlCorreo),
                  SizedBox(height: 18.0),
                  Input.control(
                      formControlName: 'contrasenia',
                      labelText: 'Contraseña',
                      errorText: 'Ingrese Contraseña',
                      isContrasenia: true,
                      type: Envinronment.controlText),
                  SizedBox(height: 18.0),
                  Input.control(
                      formControlName: 'repetirContrasenia',
                      labelText: 'Repetir Contraseña',
                      errorText: 'Ingrese Repetir Contraseña',
                      isContrasenia: true,
                      type: Envinronment.controlText),
                  SizedBox(height: 18.0),
                  Input.selectRol(
                      formControlName: 'idRol',
                      labelText: 'Rol',
                      errorText: 'Seleccione el Rol',
                      roles: roles,
                      onClicked: (value) {
                        _handleModalRol();
                      }),
                  SizedBox(height: 22.0),
                  _buttonSubmit(context)
                ],
              ))
        ],
      ),
    );
  }

  Widget _buttonSubmit(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 35),
        backgroundColor: Envinronment.colorButton,
        shape: StadiumBorder(),
        elevation: 0,
      ),
      child: Container(
          child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(FontAwesomeIcons.floppyDisk, color: Envinronment.colorBlack),
          Container(
            padding: EdgeInsets.only(left: 5),
            child: Text(_isCreate ? 'Grabar' : 'Actualizar',
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
    await usuarioProvider.handleSubmit(context);
    context.loaderOverlay.hide();
  }

  _handleModalRol() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Dialog(
        insetPadding: EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Módulos',style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 20,),
                Text('Administrador',style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 15,),
                Container(margin:EdgeInsets.only(left: 15),child: Text('• Artículo')),
                SizedBox(height: 5,),
                Container(margin:EdgeInsets.only(left: 15),child: Text('• Almacén')),
                SizedBox(height: 5,),
                Container(margin:EdgeInsets.only(left: 15),child: Text('• Proyecto')),
                SizedBox(height: 5,),
                Container(margin:EdgeInsets.only(left: 15),child: Text('• Usuario')),
                SizedBox(height: 15,),
                Text('Almacenero',style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 15,),
                Container(margin:EdgeInsets.only(left: 15),child: Text('• Artículo')),
                SizedBox(height: 5,),
                Container(margin:EdgeInsets.only(left: 15),child: Text('• Almacén')),
                SizedBox(height: 5,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
