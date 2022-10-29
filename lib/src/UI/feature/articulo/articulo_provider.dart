import 'dart:io';
import 'dart:typed_data';

import 'package:controlinventario/src/core/interfaces/response-articulo.dart';
import 'package:controlinventario/src/core/interfaces/response-categoria.dart';
import 'package:controlinventario/src/core/interfaces/response-imagen.dart';
import 'package:controlinventario/src/core/util/constantes.dart';
import 'package:controlinventario/src/core/util/routes.dart';
import 'package:controlinventario/src/infraestructure/articulo_service.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:http/http.dart' as http;
import '../../../domain/articulo.dart';
import 'package:path/path.dart' as path;

class ArticuloProvider with ChangeNotifier {
  ArticuloService _articuloService = new ArticuloService();
  late File? file;

  FormGroup form = new FormGroup({
    'id': FormControl<String>(value: ''),
    'nombre': FormControl<String>(value: '', validators: [Validators.required]),
    'idCategoria':
        FormControl<String>(value: '', validators: [Validators.required]),
    'precio': FormControl<String>(value: '', validators: [Validators.required]),
  });

  Future<void> handleSubmit(BuildContext context, File? image) async {
    bool notEmptyImage = image == null ? true : false;

    if (form.invalid) {
      form.markAllAsTouched();
      return;
    }

    if (notEmptyImage) {
      SnackBar snackBar = SnackBar(
          content: Text('Ingrese una imagen',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
          duration: Duration(seconds: 1),
          backgroundColor: Envinronment.colorDanger);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          snackBar,
        );
      });
      return;
    }

    ResponseImagen responseImagen = await _articuloService.postImagen(image);

    late ResponseArticulo response;
    if (form.value["id"].toString().length > 0 &&
        form.value["id"].toString() != 'null') {
      response =
          await _articuloService.putArticulo(form.value, responseImagen.data);
    } else {
      response =
          await _articuloService.postArticulo(form.value, responseImagen.data);
    }

    if (response.status) {
      this.form.reset(removeFocus: true);

      SnackBar snackBar = SnackBar(
          content: Text(response.message,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
          duration: Duration(seconds: 3),
          backgroundColor: Envinronment.colorSecond);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          snackBar,
        );
      });

      Navigator.pop(context, Routes.ARTICULO);
    } else {
      SnackBar snackBar = SnackBar(
          content: Text(response.message,
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Envinronment.colorWhite)),
          duration: Duration(seconds: 3),
          backgroundColor: Envinronment.colorDanger);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          snackBar,
        );
      });
    }
  }

  void initializeForm(Articulo articulo) async {
    final value = {
      'id': articulo.id.toString(),
      'nombre': articulo.nombre,
      'idCategoria': articulo.categoria.id.toString(),
      'precio': articulo.precio.toString()
    };
    form.patchValue(value);
  }

  Future<void> initializeImagen(Articulo articulo) async {
    final directory = await getApplicationDocumentsDirectory();
    final fullPath = "${Envinronment.URL_BLOB}${articulo.url}";
    Uint8List fileBytes = await http.readBytes(Uri.parse(fullPath));
    final fileNombre = articulo.url.split(Envinronment.URL_SPLIT_IMAGE)[1];
    file = await File('${directory.path}/$fileNombre').writeAsBytes(fileBytes);
  }

  void cleanForm() {
    form.reset(removeFocus: true);
  }

  Future<ResponseCategoria> getCategorias() async {
    ResponseCategoria response = await _articuloService.getCategorias();
    return response;
  }

  Future<ResponseArticulo> getArticulos() async {
    ResponseArticulo response = await _articuloService.getArticulos();
    return response;
  }

  Future<ResponseArticulo> deleteArticulo(int idArticulo) async {
    ResponseArticulo response =
        await _articuloService.deleteArticulo(idArticulo);
    return response;
  }
}
