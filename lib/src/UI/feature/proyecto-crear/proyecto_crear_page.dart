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
import 'package:loader_overlay/loader_overlay.dart';

class ProyectoCrearPage extends StatefulWidget {
  @override
  State<ProyectoCrearPage> createState() => _ProyectoCrearPageState();
}

class _ProyectoCrearPageState extends State<ProyectoCrearPage> {
  bool _procesandoLoading = false;
  bool _isVigente = false;
  bool _isConcluido = false;
  bool _isCreate = true;
  late ProyectoProvider proyectoProvider;
  late AlmacenProvider almacenProvider;
  late ArticuloProvider articuloProvider;
  bool _loadedArticulos = true;

  @override
  Widget build(BuildContext context) {
    proyectoProvider = Provider.of<ProyectoProvider>(context, listen: false);
    almacenProvider = Provider.of<AlmacenProvider>(context, listen: false);
    articuloProvider = Provider.of<ArticuloProvider>(context, listen: false);
    proyectoProvider.cleanForm();
    proyectoProvider.cleanFormConcluido();

    final argument = (ModalRoute.of(context)!.settings.arguments);
    if (argument != null) {
      final proyectoArgument = argument as Proyecto;
      _isVigente =
          proyectoArgument.estado == EProyecto.VIGENTE.index ? true : false;
      _isConcluido =
          proyectoArgument.estado == EProyecto.CONCLUIDO.index ? true : false;
      proyectoProvider.initializeForm(proyectoArgument);
      _isCreate = false;
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
                Navigator.pop(context, Routes.PROYECTO);
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
                            (snapshot.data![0] as ResponseAlmacen).data;
                        List<Articulo> articulos =
                            (snapshot.data![1] as ResponseArticulo).data;
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
                  _isVigente ? _buttonVigente(context, articulos) : Container(),
                  _isCreate ? _buttonSubmitCreate(context) : Container(),
                  SizedBox(height: 10),
                ],
              ))
        ],
      ),
    );
  }

  Widget _buttonVigente(BuildContext context, List<Articulo> articulos) {
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
          onPressed: () {
            Navigator.pushNamed(context, Routes.PROYECTO_CONCLUIDO,
                arguments: articulos);
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
    await proyectoProvider.handleSubmit(context);
    context.loaderOverlay.hide();
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
          onPressed: () async {
            final articuloForm = ArticuloForm.fromJson(currentform.value);
            handleModalAgregar(almacenes, articulos, false, index);
            setState(() => this._loadedArticulos = false);
            await proyectoProvider.initializeFormArticulo(
                articuloForm.idAlmacen, articuloForm.id, articuloForm.cantidad);
            setState(() => this._loadedArticulos = true);
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
                      ReactiveValueListenableBuilder<String>(
                        formControlName: 'idAlmacen',
                        builder: (context, form, child) {
                          var idAlm = form.value.toString();

                          if (idAlm != 'null') {
                            var almacenFound = almacenes.firstWhere(
                                (alm) => alm.id.toString() == idAlm);
                            proyectoProvider.listaArticulos =
                                almacenFound.articulo;
                          }

                          if (_loadedArticulos) {
                            proyectoProvider.formArticulo.controls["id"]!
                                .reset(value: '', emitEvent: false);
                          }

                          return Input.selectArticulo(
                              formControlName: 'id',
                              labelText: 'Artículo',
                              errorText: 'Seleccione el artículo',
                              articulos: proyectoProvider.listaArticulos);
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      ReactiveValueListenableBuilder<String>(
                          formControlName: 'id',
                          builder: (context, form, child) {
                            String idCate = form.value.toString();
                            print('###############3');
                            print(idCate);
                            if (idCate != 'null' &&
                                proyectoProvider.listaArticulos.length > 0) {
                              Articulo articuloFound;
                              articuloFound = proyectoProvider.listaArticulos
                                  .firstWhere(
                                      (alm) => alm.id.toString() == idCate);

                              return Column(
                                children: [
                                  Text('Información del artículo',
                                      style: TextStyle(
                                          color: Envinronment.colorPrimary,
                                          fontWeight: FontWeight.bold)),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 5),
                                    child: Row(
                                      children: [
                                        Text('${articuloFound.nombre}',
                                            style: TextStyle(fontSize: 11)),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text('Precio:',
                                          style: TextStyle(
                                              color: Envinronment.colorPrimary,
                                              fontSize: 12)),
                                      SizedBox(width: 5),
                                      Text('${articuloFound.precio}',
                                          style: TextStyle(
                                              color: Envinronment.colorPrimary,
                                              fontSize: 12)),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('Disponible:',
                                          style: TextStyle(
                                              color: Envinronment.colorPrimary,
                                              fontSize: 12)),
                                      SizedBox(width: 5),
                                      Text('${articuloFound.cantidad}',
                                          style: TextStyle(
                                              color: Envinronment.colorPrimary,
                                              fontSize: 12)),
                                    ],
                                  ),
                                ],
                              );
                            } else {
                              return Container();
                            }
                          }),
                      SizedBox(
                        height: 15,
                      ),
                      Input.control(
                          formControlName: 'cantidad',
                          labelText: 'Cantidad',
                          errorText: 'Ingresa Cantidad',
                          isContrasenia: false,
                          type: Envinronment.controlNumber),
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
