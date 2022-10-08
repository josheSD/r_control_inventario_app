import 'dart:io';

import 'package:controlinventario/src/core/interfaces/response-articulo.dart';
import 'package:controlinventario/src/core/interfaces/response-categoria.dart';
import 'package:controlinventario/src/core/util/constantes.dart';
import 'package:controlinventario/src/core/util/routes.dart';
import 'package:controlinventario/src/infraestructure/articulo_service.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../domain/articulo.dart';

class ArticuloProvider with ChangeNotifier {
  ArticuloService _articuloService = new ArticuloService();

  FormGroup form = new FormGroup({
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

    Navigator.pushNamed(context, Routes.ARTICULO);
  }

  void initializeForm(Articulo articulo) {
    final value = {
      'nombre': articulo.nombre,
      'idCategoria': articulo.categoria.id.toString(),
      'precio': articulo.precio.toString()
    };
    form.patchValue(value);
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

  Future<ResponseArticulo> postArticulo(Articulo articulo) async {
    ResponseArticulo response = await _articuloService.postArticulo(articulo);
    return response;
  }

  Future<ResponseArticulo> putArticulo(Articulo articulo) async {
    ResponseArticulo response = await _articuloService.putArticulo(articulo);
    return response;
  }

  Future<ResponseArticulo> deleteArticulo(int idArticulo) async {
    ResponseArticulo response =
        await _articuloService.deleteArticulo(idArticulo);
    return response;
  }
}
