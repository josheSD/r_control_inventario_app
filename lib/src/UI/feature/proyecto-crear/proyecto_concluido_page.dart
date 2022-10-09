import 'package:controlinventario/src/UI/feature/proyecto/proyecto_provider.dart';
import 'package:controlinventario/src/core/util/constantes.dart';
import 'package:controlinventario/src/core/util/routes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ProyectoConcludioPage extends StatefulWidget {
  const ProyectoConcludioPage({super.key});

  @override
  State<ProyectoConcludioPage> createState() => _ProyectoConcludioPageState();
}

class _ProyectoConcludioPageState extends State<ProyectoConcludioPage> {
  late ProyectoProvider proyectoProvider;
  bool _procesandoLoding = false;

  @override
  Widget build(BuildContext context) {
    proyectoProvider = Provider.of<ProyectoProvider>(context, listen: false);

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
        body: _buildBody());
  }

  _buildBody() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 30),
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
                                      child: Text('Sierra Circular')),
                                  Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 8),
                                      child: Text('')),
                                  Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 8),
                                      child: Text('')),
                                ]),
                            ],
                          ),
                        );
                      }),
                  SizedBox(height: 22.0),
                  _buttonSubmit(context)
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
      onPressed: _procesandoLoding ? null : () => {
        Navigator.pushNamed(context, Routes.PROYECTO)
      },
    );
  }
}
