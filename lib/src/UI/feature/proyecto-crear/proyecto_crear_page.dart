import 'package:controlinventario/src/UI/feature/almacen/almacen_provider.dart';
import 'package:controlinventario/src/UI/feature/proyecto/proyecto_provider.dart';
import 'package:controlinventario/src/core/interfaces/response-almacen.dart';
import 'package:controlinventario/src/core/interfaces/response-articulo.dart';
import 'package:controlinventario/src/core/util/constantes.dart';
import 'package:controlinventario/src/core/util/routes.dart';
import 'package:controlinventario/src/domain/almacen.dart';
import 'package:controlinventario/src/domain/articulo.dart';
import 'package:controlinventario/src/domain/proyecto.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../core/components/input.dart';
import '../../../domain/articulo-form.dart';
import '../articulo/articulo_provider.dart';

class ProyectoCrearPage extends StatefulWidget {
  @override
  State<ProyectoCrearPage> createState() => _ProyectoCrearPageState();
}

class _ProyectoCrearPageState extends State<ProyectoCrearPage> {
  bool _procesandoLoding = false;
  bool _isVigente = false;
  bool _isConcluido = false;
  bool _isCreate = true;
  late ProyectoProvider proyectoProvider;
  late AlmacenProvider almacenProvider;
  late ArticuloProvider articuloProvider;

  @override
  Widget build(BuildContext context) {
    proyectoProvider = Provider.of<ProyectoProvider>(context, listen: false);
    almacenProvider = Provider.of<AlmacenProvider>(context, listen: false);
    articuloProvider = Provider.of<ArticuloProvider>(context, listen: false);
    proyectoProvider.cleanForm();

    final argument = (ModalRoute.of(context)!.settings.arguments);
    if (argument != null) {
      final proyectoArgument = argument as Proyecto;
      _isVigente =
          proyectoArgument.estado == EProyecto.VIGENTE.index ? true : false;
      _isConcluido =
          proyectoArgument.estado == EProyecto.CONCLUIDO.index ? true : false;
      _isCreate = false;
      proyectoProvider.initializeForm(proyectoArgument);
    }

    return Scaffold(
        backgroundColor: Envinronment.colorBackground,
        appBar: AppBar(
          title: Text('Proyecto',
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
                Navigator.pop(context);
              },
            );
          }),
        ),
        body: SafeArea(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: FutureBuilder(
                    future: Future.wait([
                      almacenProvider.getAlmacenes(),
                      articuloProvider.getArticulos()
                    ]),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<dynamic>> snapshot) {
                      if (snapshot.hasData) {
                        List<Almacen> almacenes =
                            (snapshot.data![0] as ResponseAlmacen).data!;
                        List<Articulo> articulos =
                            (snapshot.data![1] as ResponseArticulo).data!;
                        return _buildBody(almacenes, articulos, context);
                      } else {
                        return Center(
                            child: CircularProgressIndicator(
                                color: Envinronment.colorSecond));
                      }
                    }))));
  }

  Widget _buildBody(
      List<Almacen> almacenes, List<Articulo> articulos, BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ReactiveForm(
              formGroup: proyectoProvider.form,
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
                      formControlName: 'cliente',
                      labelText: 'Cliente',
                      errorText: 'Ingrese Cliente',
                      isContrasenia: false,
                      type: Envinronment.controlText),
                  SizedBox(height: 18.0),
                  Input.calendar(
                    formControlName: 'fechaInicio',
                    labelText: 'Fecha inicio del Proyecto',
                    errorText: 'Ingrese fecha inicio del Proyecto',
                  ),
                  SizedBox(height: 18.0),
                  Input.calendar(
                      formControlName: 'fechaFin',
                      labelText: 'Fecha fin del Proyecto',
                      errorText: 'Ingrese fecha fin del Proyecto'),
                  SizedBox(height: 18.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Artículo'),
                      _isConcluido
                          ? Container()
                          : _buildAgregar(almacenes, articulos)
                    ],
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
                                      proyectoProvider
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
                                                      proyectoProvider
                                                          .articulosList
                                                          .controls[index]
                                                          .value)
                                                  .id)
                                          .nombre)),
                                  Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 8),
                                      child: Text(ArticuloForm.fromJson(
                                              proyectoProvider.articulosList
                                                  .controls[index].value)
                                          .cantidad)),
                                  _isConcluido
                                      ? Container()
                                      : Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 8),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              _buildActualizar(
                                                  proyectoProvider.articulosList
                                                      .controls[index],
                                                  index,
                                                  articulos,
                                                  almacenes),
                                              _buildEliminar(index),
                                            ],
                                          )),
                                ]),
                            ],
                          ),
                        );
                      }),
                  SizedBox(height: 22.0),
                  _isVigente ? _buttonVigente(context) : Container(),
                  _isCreate ? _buttonSubmitCreate(context) : Container(),
                ],
              ))
        ],
      ),
    );
  }

  Widget _buttonVigente(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            side: BorderSide(width: 1.0, color: Envinronment.colorButton),
            backgroundColor: Envinronment.colorWhite,
            shape: StadiumBorder(),
            elevation: 0,
          ),
          child: Container(
              child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                FontAwesomeIcons.check,
                color: Envinronment.colorBlack,
                size: 18,
              ),
              Container(
                padding: EdgeInsets.only(left: 8),
                child: Text('Concluir',
                    style: TextStyle(
                        color: Envinronment.colorBlack,
                        fontWeight: FontWeight.normal)),
              ),
              _procesandoLoding
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
          onPressed: () {
            Navigator.pushNamed(context, Routes.PROYECTO_CONCLUIDO);
          },
        ),
        ElevatedButton(
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
                FontAwesomeIcons.floppyDisk,
                color: Envinronment.colorBlack,
                size: 18,
              ),
              Container(
                padding: EdgeInsets.only(left: 8),
                child: Text('Actualizar',
                    style: TextStyle(
                        color: Envinronment.colorBlack,
                        fontWeight: FontWeight.normal)),
              ),
              _procesandoLoding
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
          onPressed: _procesandoLoding ? null : () => {_onPressed(context)},
        ),
      ],
    );
  }

  Widget _buttonSubmitCreate(BuildContext context) {
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
            child: Text('Guardar',
                style: TextStyle(
                    color: Envinronment.colorBlack,
                    fontWeight: FontWeight.normal)),
          ),
          _procesandoLoding
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
      onPressed: _procesandoLoding ? null : () => {_onPressed(context)},
    );
  }

  _onPressed(BuildContext context) async {
    await proyectoProvider.handleSubmit(context);
  }

  _buildActualizar(AbstractControl<dynamic> currentform, int index,
      List<Articulo> articulos, List<Almacen> almacenes) {
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
            proyectoProvider.initializeFormArticulo(articuloForm.idAlmacen,
                articuloForm.id, articuloForm.cantidad);
            handleModalAgregar(almacenes, articulos, false, index);
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
                      proyectoProvider.removeFormArray(index);
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

  _buildAgregar(List<Almacen> almacenes, List<Articulo> articulos) {
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
          proyectoProvider.cleanFormArticulo();
          handleModalAgregar(almacenes, articulos, true, 0);
        });
  }

  handleModalAgregar(List<Almacen> almacenes, List<Articulo> articulos,
      bool isCreate, int index) {
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
                formGroup: proyectoProvider.formArticulo,
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
                      Input.selectAlmacen(
                          formControlName: 'idAlmacen',
                          labelText: 'Almacén',
                          errorText: 'Seleccione el Almacén',
                          almacenes: almacenes),
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
                                    await proyectoProvider.handleSubmitArticulo(
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
