import 'dart:io';

import 'package:controlinventario/src/UI/feature/almacen/almacen_provider.dart';
import 'package:controlinventario/src/UI/feature/articulo/articulo_provider.dart';
import 'package:controlinventario/src/core/components/input.dart';
import 'package:controlinventario/src/core/interfaces/response-articulo.dart';
import 'package:controlinventario/src/core/util/constantes.dart';
import 'package:controlinventario/src/domain/almacen.dart';
import 'package:controlinventario/src/domain/articulo.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../core/util/routes.dart';
import '../../../domain/articulo-form.dart';
import 'package:loader_overlay/loader_overlay.dart';

class AlmacenCrearPage extends StatefulWidget {
  @override
  State<AlmacenCrearPage> createState() => _AlmacenCrearPageState();
}

class _AlmacenCrearPageState extends State<AlmacenCrearPage> {
  bool _procesandoLoading = false;
  bool _isCreate = true;
  late AlmacenProvider almacenProvider;
  late ArticuloProvider articuloProvider;

  @override
  Widget build(BuildContext context) {
    almacenProvider = Provider.of<AlmacenProvider>(context, listen: false);
    articuloProvider = Provider.of<ArticuloProvider>(context, listen: false);
    almacenProvider.cleanForm();

    final argument = (ModalRoute.of(context)!.settings.arguments);
    if (argument != null) {
      almacenProvider.initializeForm(argument as Almacen);
      _isCreate = false;
    }

    return Scaffold(
        backgroundColor: Envinronment.colorBackground,
        appBar: AppBar(
          title: Text('Almacén',
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
                Navigator.pushReplacementNamed(context,Routes.ALMACEN);
              },
            );
          }),
        ),
        body: SafeArea(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: FutureBuilder(
                    future: articuloProvider.getArticulos(),
                    builder: (BuildContext context,
                        AsyncSnapshot<ResponseArticulo> snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.status) {
                          List<Articulo> articulos = snapshot.data!.data;

                          return _buildBody(articulos, context);
                        } else {
                          return Container();
                        }
                      } else {
                        return Center(
                            child: CircularProgressIndicator(
                                color: Envinronment.colorSecond));
                      }
                    }))));
  }

  Widget _buildBody(List<Articulo> articulos, BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ReactiveForm(
              formGroup: almacenProvider.form,
              child: Column(
                children: [
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Artículo'), _buildAgregar(articulos)],
                  ),
                  SizedBox(height: 18.0),
                  ReactiveFormArray(
                      formArrayName: 'articulos',
                      builder: (context, formArray, child) {
                        return Container(
                          decoration:
                              BoxDecoration(color: Envinronment.colorWhite),
                          child: Table(
                            defaultVerticalAlignment:
                                TableCellVerticalAlignment.middle,
                            border: TableBorder.all(
                                color: Envinronment.colorPrimary),
                            columnWidths: {
                              1: FixedColumnWidth(80),
                              2: FixedColumnWidth(125),
                            },
                            children: [
                              TableRow(children: [
                                Container(
                                    margin: EdgeInsets.symmetric(vertical: 8),
                                    child: Text('Nombre',
                                        textAlign: TextAlign.center)),
                                Container(
                                    padding: EdgeInsets.symmetric(vertical: 8),
                                    child: Text('Cantidad',
                                        textAlign: TextAlign.center)),
                                Container(
                                    padding: EdgeInsets.symmetric(vertical: 8),
                                    child: Text('Acción',
                                        textAlign: TextAlign.center)),
                              ]),
                              for (int index = 0;
                                  index <
                                      almacenProvider
                                          .articulosList.controls.length;
                                  index++)
                                TableRow(children: [
                                  Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 8),
                                      child: Text(articulos
                                          .firstWhere((element) =>
                                              element.id.toString() ==
                                              ArticuloForm.fromJson(
                                                      almacenProvider
                                                          .articulosList
                                                          .controls[index]
                                                          .value)
                                                  .id)
                                          .nombre)),
                                  Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 8),
                                      child: Text(ArticuloForm.fromJson(
                                              almacenProvider.articulosList
                                                  .controls[index].value)
                                          .cantidad)),
                                  Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          _buildActualizar(
                                              almacenProvider.articulosList
                                                  .controls[index],
                                              index,
                                              articulos),
                                          _buildEliminar(index),
                                        ],
                                      )),
                                ]),
                            ],
                          ),
                        );
                      }),
                  SizedBox(height: 22.0),
                  _buttonSubmit(context),
                  SizedBox(height: 10),
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
          Icon(
            FontAwesomeIcons.floppyDisk,
            color: Envinronment.colorBlack,
            size: 18,
          ),
          Container(
            padding: EdgeInsets.only(left: 8),
            child: Text(_isCreate ? 'Guardar' : 'Actualizar',
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
    await almacenProvider.handleSubmit(context);
    context.loaderOverlay.hide();
  }

  _buildActualizar(AbstractControl<dynamic> currentform, int index,
      List<Articulo> articulos) {
    return SizedBox(
      width: 45,
      height: 30,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Envinronment.colorButton,
            elevation: 0,
          ),
          child: Container(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  FontAwesomeIcons.pencil,
                  color: Envinronment.colorSecond,
                  size: 13,
                ),
              ],
            ),
          ),
          onPressed: () {
            final articuloForm = ArticuloForm.fromJson(currentform.value);
            almacenProvider.initializeFormArticulo(
                articuloForm.id, articuloForm.cantidad);
            handleModalAgregar(articulos, false, index);
          }),
    );
  }

  _buildEliminar(int index) {
    return SizedBox(
      width: 45,
      height: 30,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Envinronment.colorButton,
            elevation: 0,
          ),
          child: Container(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  FontAwesomeIcons.trash,
                  color: Envinronment.colorDanger,
                  size: 13,
                ),
              ],
            ),
          ),
          onPressed: () {
            handleDelete(index);
          }),
    );
  }

  handleDelete(int index) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text('¿Está seguro de eliminar?',
            style: TextStyle(color: Envinronment.colorBlack, fontSize: 14)),
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      side: BorderSide(
                          width: 1.0, color: Envinronment.colorButton),
                      backgroundColor: Envinronment.colorWhite,
                      shape: StadiumBorder(),
                      elevation: 0,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('No',
                        style: TextStyle(
                            color: Envinronment.colorBlack,
                            fontWeight: FontWeight.normal))),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Envinronment.colorButton,
                      shape: StadiumBorder(),
                      elevation: 0,
                    ),
                    onPressed: () async {
                      Navigator.pop(context);
                      almacenProvider.removeFormArray(index);
                    },
                    child: Text('Si',
                        style: TextStyle(
                            color: Envinronment.colorBlack,
                            fontWeight: FontWeight.normal)))
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildAgregar(List<Articulo> articulos) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Envinronment.colorButton,
          shape: StadiumBorder(),
          elevation: 0,
        ),
        child: Container(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                FontAwesomeIcons.plus,
                color: Envinronment.colorBlack,
                size: 14,
              ),
              Container(
                padding: EdgeInsets.only(left: 5),
                child: Text('Nuevo',
                    style: TextStyle(
                        color: Envinronment.colorBlack,
                        fontWeight: FontWeight.normal,
                        fontSize: 12)),
              ),
            ],
          ),
        ),
        onPressed: () {
          almacenProvider.cleanFormArticulo();
          handleModalAgregar(articulos, true, 0);
        });
  }

  handleModalAgregar(List<Articulo> articulos, bool isCreate, int index) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        insetPadding: EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ReactiveForm(
                formGroup: almacenProvider.formArticulo,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 30),
                  child: Column(
                    children: <Widget>[
                      Text(isCreate ? 'Agregar' : 'Actualizar',
                          style: TextStyle(
                              color: Envinronment.colorBlack, fontSize: 14),
                          textAlign: TextAlign.center),
                      SizedBox(
                        height: 15,
                      ),
                      Input.selectArticulo(
                          formControlName: 'id',
                          labelText: 'Artículo',
                          errorText: 'Seleccione el artículo',
                          articulos: articulos),
                      SizedBox(height: 18.0),
                      Input.control(
                          formControlName: 'cantidad',
                          labelText: 'Cantidad',
                          errorText: 'Ingresa Cantidad',
                          isContrasenia: false,
                          type: Envinronment.controlText),
                      SizedBox(height: 18.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                side: BorderSide(
                                    width: 1.0,
                                    color: Envinronment.colorButton),
                                backgroundColor: Envinronment.colorWhite,
                                shape: StadiumBorder(),
                                elevation: 0,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Cancelar',
                                  style: TextStyle(
                                      color: Envinronment.colorBlack,
                                      fontWeight: FontWeight.normal))),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Envinronment.colorButton,
                                shape: StadiumBorder(),
                                elevation: 0,
                              ),
                              onPressed: () async {
                                bool isValid =
                                    await almacenProvider.handleSubmitArticulo(
                                        context, isCreate, index);
                                if (isValid) {
                                  Navigator.pop(context);
                                }
                              },
                              child: Row(
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(right: 8),
                                      child: Icon(FontAwesomeIcons.floppyDisk,
                                          color: Envinronment.colorBlack,
                                          size: 16)),
                                  Text(isCreate ? 'Insertar' : 'Actualizar',
                                      style: TextStyle(
                                          color: Envinronment.colorBlack,
                                          fontWeight: FontWeight.normal)),
                                ],
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
