import 'dart:io';

import 'package:controlinventario/src/UI/feature/inventario-crear/inventario_crear_provider.dart';
import 'package:controlinventario/src/core/components/image-default.dart';
import 'package:controlinventario/src/core/components/image.dart';
import 'package:controlinventario/src/core/components/input.dart';
import 'package:controlinventario/src/core/interfaces/response-tipo-inventario.dart';
import 'package:controlinventario/src/core/util/constantes.dart';
import 'package:controlinventario/src/domain/tipo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as path;
import 'package:reactive_forms/reactive_forms.dart';

class InventarioCrearPage extends StatefulWidget {
  @override
  State<InventarioCrearPage> createState() => _InventarioCrearPageState();
}

class _InventarioCrearPageState extends State<InventarioCrearPage> {
  File? image;
  double? imageWidth;
  double? imageHeight;

  Future<void> pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = await saveImagePermanently(image.path);
      final decodedImage =
          await decodeImageFromList(imageTemporary.readAsBytesSync());
      imageWidth = decodedImage.width.toDouble();
      imageHeight = decodedImage.height.toDouble();

      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  void removeImage() {
    setState(() => this.image = null);
  }
  

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

                          return _buildBody(
                              inventarioCrearProvider, tipoInventario, context);
                        } else {
                          // Mostrando mensaje
                          SnackBar snackBar = SnackBar(
                              content: Text('${snapshot.data!.message}',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold)),
                              duration: Duration(seconds: 2),
                              backgroundColor: Colors.red);
                          // WidgetsBinding.instance.addPostFrameCallback((_) {
                          //   Scaffold.of(context)
                          //     ..hideCurrentSnackBar()
                          //     ..showSnackBar(snackBar);
                          // });

                          return Container();
                        }
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    }))));
  }

  Widget _buildBody(InventarioCrearProvider inventarioCrearProvider,
      List<TipoInventario> tipoInventario, BuildContext context) {
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
                  image != null
                      ? ImageWidget(
                          image: image!,
                          imageWidth: imageWidth!,
                          imageHeight: imageHeight!,
                          onClicked: (source) => pickImage(source),
                          onRemove: (e) => removeImage())
                      : ImageDefault(
                          onClicked: (source) => pickImage(source),
                        ),
                  SizedBox(
                    height: 25.0,
                  ),
                  Input.select(
                      formControlName: 'tipo',
                      labelText: 'Tipo',
                      errorText: 'Ingrese Tipo',
                      tipoInventario: tipoInventario),
                  SizedBox(height: 18.0),
                  Input.control(
                      formControlName: 'nombre',
                      labelText: 'Nombre',
                      errorText: 'Ingrese Nombre',
                      isContrasenia: false,
                      type: Envinronment.controlText),
                  SizedBox(height: 18.0),
                  Input.control(
                      formControlName: 'precio',
                      labelText: 'Precio',
                      errorText: 'Ingrese Precio',
                      isContrasenia: false,
                      type: Envinronment.controlNumber),
                  SizedBox(height: 15.0),
                  _buttonSubmit(inventarioCrearProvider, context)
                ],
              ))
        ],
      ),
    );
  }

  Widget _buttonSubmit(
      InventarioCrearProvider inventarioCrearProvider, BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(40),
        primary: Envinronment.colorSecond,
      ),
      child: Text('Grabar'),
      onPressed: () => {_onPressed(inventarioCrearProvider, context)},
    );
  }

  _onPressed(InventarioCrearProvider inventarioCrearProvider,
      BuildContext context) async {
    await inventarioCrearProvider.handlerSubmit(context);
  }

  Future<File> saveImagePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = path.basename(imagePath);
    final image = File('${directory.path}/${name}');
    return File(imagePath).copy(image.path);
  }
}
