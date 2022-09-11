import 'package:controlinventario/src/UI/feature/inventario-crear/inventario_crear_provider.dart';
import 'package:controlinventario/src/core/components/input.dart';
import 'package:controlinventario/src/core/interfaces/response-tipo-inventario.dart';
import 'package:controlinventario/src/core/util/constantes.dart';
import 'package:controlinventario/src/domain/tipo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';

class InventarioCrearPage extends StatefulWidget {
  @override
  State<InventarioCrearPage> createState() => _InventarioCrearPageState();
}

class _InventarioCrearPageState extends State<InventarioCrearPage> {
  @override
  Widget build(BuildContext context) {
    final inventarioCrearProvider =
        Provider.of<InventarioCrearProvider>(context, listen: false);

    return Scaffold(
        backgroundColor: Envinronment.colorBackground,
        body: SafeArea(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: FutureBuilder(
                    future: inventarioCrearProvider.getTipoInventario(),
                    builder: (BuildContext context,
                        AsyncSnapshot<ResponseTipoInventario> snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.status) {
                          List<TipoInventario> tipoInventario =
                              snapshot.data!.data;

                          return SingleChildScrollView(
                            child: Column(
                              children: [
                                ReactiveForm(
                                    formGroup: inventarioCrearProvider.form,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 25.0,
                                        ),
                                        Input.select(
                                            'tipo', 'Tipo', 'Ingrese Tipo', tipoInventario),
                                        SizedBox(height: 18.0),
                                        Input.control(
                                            'nombre',
                                            'Nombre',
                                            'Ingrese Nombre',
                                            false,
                                            Envinronment.controlText),
                                        SizedBox(height: 18.0),
                                        Input.control(
                                            'precio',
                                            'Precio',
                                            'Ingrese Nombre',
                                            false,
                                            Envinronment.controlNumber),
                                      ],
                                    ))
                              ],
                            ),
                          );

                        } else {
                          // Mostrando mensaje
                          SnackBar snackBar = SnackBar(
                              content: Text('${snapshot.data!.message}',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold)),
                              duration: Duration(seconds: 2),
                              backgroundColor: Colors.red);
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            Scaffold.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(snackBar);
                          });

                          return Container();
                        }
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    }))));
  }
}
