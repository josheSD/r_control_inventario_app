import 'package:controlinventario/src/UI/feature/proyecto/proyecto_provider.dart';
import 'package:controlinventario/src/core/util/constantes.dart';
import 'package:controlinventario/src/core/util/routes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../domain/articulo-form.dart';
import '../../../domain/articulo.dart';
import 'package:loader_overlay/loader_overlay.dart';

class ProyectoConcludioPage extends StatefulWidget {
  const ProyectoConcludioPage({super.key});

  @override
  State<ProyectoConcludioPage> createState() => _ProyectoConcludioPageState();
}

class _ProyectoConcludioPageState extends State<ProyectoConcludioPage> {
  late ProyectoProvider proyectoProvider;
  bool _procesandoLoding = false;
  late List<Articulo> articulos;

  @override
  Widget build(BuildContext context) {
    proyectoProvider = Provider.of<ProyectoProvider>(context, listen: false);

    final argument = (ModalRoute.of(context)!.settings.arguments);
    if (argument != null) {
      final articulosProyecto = argument as List<Articulo>;
      articulos = articulosProyecto;
      proyectoProvider.initializeFormConcluido();
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
                Navigator.pop(context,Routes.PROYECTO_CREAR);
              },
            );
          }),
        ),
        body: _buildBody());
  }

  _buildBody() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
          child: Column(
        children: [
          ReactiveForm(
              formGroup: proyectoProvider.formConcluido,
              child: Column(
                children: [
                  ReactiveFormArray(
                      formArrayName: 'articulos',
                      builder: (context, formArray, child) {
                        return Container(
                          child: Table(
                            defaultVerticalAlignment:
                                TableCellVerticalAlignment.middle,
                            border: TableBorder(
                                horizontalInside: BorderSide(
                                    color: Envinronment.colorPrimary,
                                    width: 1)),
                            columnWidths: {
                              0: FixedColumnWidth(120),
                            },
                            children: [
                              TableRow(children: [
                                Container(
                                    margin: EdgeInsets.symmetric(vertical: 8),
                                    child: Text('Estado Artículo',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))),
                                Container(
                                    padding: EdgeInsets.symmetric(vertical: 8),
                                    child: Text('Buena',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))),
                                Container(
                                    padding: EdgeInsets.symmetric(vertical: 8),
                                    child: Text('Dañado',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))),
                              ]),
                              for (int index = 0;
                                  index <
                                      proyectoProvider
                                          .articuloConcluidos.controls.length;
                                  index++)
                                TableRow(children: [
                                  Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(articulos
                                              .firstWhere((element) =>
                                                  element.id.toString() ==
                                                  ArticuloForm.fromJson(
                                                          proyectoProvider
                                                              .articulosList
                                                              .controls[index]
                                                              .value)
                                                      .id)
                                              .nombre),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Text('Cantidad: '),
                                              Text(ArticuloForm.fromJson(
                                                      proyectoProvider
                                                          .articulosList
                                                          .controls[index]
                                                          .value)
                                                  .cantidad),
                                            ],
                                          ),
                                        ],
                                      )),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 8),
                                    child: ReactiveForm(
                                      formGroup: proyectoProvider
                                          .articuloConcluidos
                                          .controls[index] as FormGroup,
                                      child: ReactiveTextField(
                                        formControlName: 'buena',
                                        textInputAction: TextInputAction.next,
                                        validationMessages: {
                                          ValidationMessage.required: (error) =>
                                              'Ingrese'
                                        },
                                        keyboardType: TextInputType.number,
                                        cursorColor: Envinronment.colorPrimary,
                                        style: TextStyle(
                                          color: Envinronment.colorPrimary,
                                          decorationColor:
                                              Envinronment.colorPrimary,
                                        ),
                                        decoration: InputDecoration(
                                            isDense: true,
                                            contentPadding: EdgeInsets.all(9),
                                            filled: true,
                                            fillColor: Envinronment.colorWhite,
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                      Envinronment.colorDanger),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Envinronment
                                                      .colorPrimary),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                      Envinronment.colorDanger),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Envinronment
                                                      .colorPrimary),
                                            ),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Envinronment
                                                      .colorPrimary),
                                            )),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 8),
                                    child: ReactiveForm(
                                      formGroup: proyectoProvider
                                          .articuloConcluidos
                                          .controls[index] as FormGroup,
                                      child: ReactiveTextField(
                                          formControlName: 'daniado',
                                          textInputAction: TextInputAction.next,
                                          validationMessages: {
                                            ValidationMessage.required:
                                                (error) => 'Ingrese'
                                          },
                                          keyboardType: TextInputType.number,
                                          cursorColor:
                                              Envinronment.colorPrimary,
                                          style: TextStyle(
                                            color: Envinronment.colorPrimary,
                                            decorationColor:
                                                Envinronment.colorPrimary,
                                          ),
                                          decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding: EdgeInsets.all(9),
                                              filled: true,
                                              fillColor:
                                                  Envinronment.colorWhite,
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Envinronment
                                                        .colorDanger),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Envinronment
                                                        .colorPrimary),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Envinronment
                                                        .colorDanger),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Envinronment
                                                        .colorPrimary),
                                              ),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Envinronment
                                                        .colorPrimary),
                                              ))),
                                    ),
                                  ),
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
      )),
    );
  }

  _buttonSubmit(BuildContext context) {
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
            FontAwesomeIcons.check,
            color: Envinronment.colorBlack,
            size: 18,
          ),
          Container(
            padding: EdgeInsets.only(left: 8),
            child: Text('Concluido',
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
    context.loaderOverlay.show();
    await proyectoProvider.handleSubmitConcluido(context);
    context.loaderOverlay.hide();
  }
}
