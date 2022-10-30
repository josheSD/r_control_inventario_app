import 'dart:io';

import 'package:controlinventario/src/core/components/image-default.dart';
import 'package:controlinventario/src/core/components/image.dart';
import 'package:controlinventario/src/core/components/input.dart';
import 'package:controlinventario/src/core/interfaces/response-categoria.dart';
import 'package:controlinventario/src/core/util/constantes.dart';
import 'package:controlinventario/src/core/util/routes.dart';
import 'package:controlinventario/src/domain/articulo.dart';
import 'package:controlinventario/src/domain/categoria.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as path;
import 'package:reactive_forms/reactive_forms.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../articulo/articulo_provider.dart';

class ArticuloCrearPage extends StatefulWidget {
  @override
  State<ArticuloCrearPage> createState() => _ArticuloCrearPageState();
}

class _ArticuloCrearPageState extends State<ArticuloCrearPage> {
  File? image;
  bool _loadedPage = false;

  bool _procesandoLoading = false;
  bool _isCreate = true;
  late ArticuloProvider articuloProvider;

  @override
  void dispose() {
    articuloProvider.cleanForm();
    super.dispose();
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = await saveImagePermanently(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  void removeImage() {
    setState(() => this.image = null);
  }

  @override
  Widget build(BuildContext context) {
    articuloProvider = Provider.of<ArticuloProvider>(context, listen: false);

    final argument = (ModalRoute.of(context)!.settings.arguments);
    if (argument != null) {
      if (!_loadedPage) {
        articuloProvider.initializeForm(argument as Articulo);
        image = articuloProvider.file;
        _loadedPage = true;
        _isCreate = false;
      }
    }

    return Scaffold(
        backgroundColor: Envinronment.colorBackground,
        appBar: AppBar(
          title: Text('Artículo',
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
                Navigator.pop(context, Routes.ARTICULO);
              },
            );
          }),
        ),
        body: SafeArea(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: FutureBuilder(
                    future: articuloProvider.getCategorias(),
                    builder: (BuildContext context,
                        AsyncSnapshot<ResponseCategoria> snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.status) {
                          List<Categoria> categorias = snapshot.data!.data;

                          return _buildBody(categorias, context);
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

  Widget _buildBody(List<Categoria> categorias, BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ReactiveForm(
              formGroup: articuloProvider.form,
              child: Column(
                children: [
                  image != null
                      ? ImageWidget(
                          image: image!,
                          onClicked: (source) => pickImage(source),
                          onRemove: (e) => handleDelete())
                      : ImageDefault(
                          onClicked: (source) => pickImage(source),
                        ),
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
                  Input.selectCategoria(
                      formControlName: 'idCategoria',
                      labelText: 'Categoría',
                      errorText: 'Seleccione la categoria',
                      categorias: categorias),
                  SizedBox(height: 18.0),
                  Input.control(
                      formControlName: 'precio',
                      labelText: 'Precio',
                      errorText: 'Ingrese Precio',
                      isContrasenia: false,
                      type: Envinronment.controlNumber),
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
    await articuloProvider.handleSubmit(context, this.image);
    context.loaderOverlay.hide();
  }

  Future<File> saveImagePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = path.basename(imagePath);
    final image = File('${directory.path}/${name}');
    return File(imagePath).copy(image.path);
  }

  handleDelete() {
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
                      removeImage();
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
}
