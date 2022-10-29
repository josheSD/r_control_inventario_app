import 'package:controlinventario/src/UI/feature/almacen/almacen_page.dart';
import 'package:controlinventario/src/core/interfaces/response-almacen.dart';
import 'package:controlinventario/src/core/util/constantes.dart';
import 'package:controlinventario/src/core/util/routes.dart';
import 'package:controlinventario/src/domain/articulo-form.dart';
import 'package:controlinventario/src/infraestructure/almacen_service.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../domain/almacen.dart';

class AlmacenProvider with ChangeNotifier {
  AlmacenService _almacenService = new AlmacenService();

  FormGroup form = new FormGroup({
    'id': FormControl<String>(value: ''),
    'nombre': FormControl<String>(value: '', validators: [Validators.required]),
    'direccion':
        FormControl<String>(value: '', validators: [Validators.required]),
    'articulos': FormArray([], validators: [Validators.required])
  });

  FormArray get articulosList => form.control('articulos') as FormArray;

  addFormArray(ArticuloForm articuloForm) async {
    articulosList.add(FormGroup({
      'id': FormControl<String>(
          value: articuloForm.id, validators: [Validators.required]),
      'cantidad': FormControl<String>(
          value: articuloForm.cantidad, validators: [Validators.required]),
    }));
  }

  updateFormArray(ArticuloForm articuloForm, index) async {
    final value = {'id': articuloForm.id, 'cantidad': articuloForm.cantidad};
    articulosList.controls[index].patchValue(value);

    final newLista = articulosList.controls.map((e) => FormGroup({
          'id': FormControl<String>(
              value: ArticuloForm.fromJson(e.value).id,
              validators: [Validators.required]),
          'cantidad': FormControl<String>(
              value: ArticuloForm.fromJson(e.value).cantidad,
              validators: [Validators.required]),
        }));

    articulosList.clear();
    articulosList.addAll(newLista.toList());
  }

  removeFormArray(int index) {
    articulosList.removeAt(index);
  }

  Future<void> handleSubmit(BuildContext context) async {
    bool isValidArticulos = true;

    if (articulosList.controls.length == 0) {
      SnackBar snackBar = SnackBar(
          content: Text('Ingrese almenos un artículo',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
          duration: Duration(seconds: 1),
          backgroundColor: Envinronment.colorDanger);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          snackBar,
        );
      });

      isValidArticulos = false;
    }

    if (form.invalid) {
      form.markAllAsTouched();
      return;
    }

    if (!isValidArticulos) {
      return;
    }

    late ResponseAlmacen response;
    if (form.value["id"].toString().length > 0 &&
        form.value["id"].toString() != 'null') {
      response = await _almacenService.putAlmacen(form.value);
    } else {
      response = await _almacenService.postAlmacen(form.value);
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
      Navigator.pop(context, Routes.ALMACEN);
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

  void initializeForm(Almacen almacen) {
    final value = {
      'id': almacen.id.toString(),
      'nombre': almacen.nombre,
      'direccion': almacen.direccion
    };
    form.patchValue(value);

    final newLista = almacen.articulo.map((e) => FormGroup({
          'id': FormControl<String>(
              value: e.id.toString(), validators: [Validators.required]),
          'cantidad': FormControl<String>(
              value: e.cantidad.toString(), validators: [Validators.required]),
        }));

    articulosList.addAll(newLista.toList());
  }

  void cleanForm() {
    articulosList.clear();
    form.reset(removeFocus: true);
  }

  Future<ResponseAlmacen> getAlmacenes() async {
    ResponseAlmacen response = await _almacenService.getAlmacenes();
    return response;
  }

  Future<ResponseAlmacen> deleteAlmacen(int idAlmacen) async {
    ResponseAlmacen response = await _almacenService.deleteAlmacen(idAlmacen);
    return response;
  }

  // ###############    Form Articulo   #########################
  FormGroup formArticulo = new FormGroup({
    'id': FormControl<String>(value: '', validators: [Validators.required]),
    'cantidad':
        FormControl<String>(value: '', validators: [Validators.required]),
  });

  Future<bool> handleSubmitArticulo(
      BuildContext context, bool isCreate, int index) async {
    bool isValid = true;
    if (formArticulo.invalid) {
      formArticulo.markAllAsTouched();
      isValid = false;
    }
    if (isCreate) {
      final articuloForm = ArticuloForm.fromJson(formArticulo.value);
      addFormArray(articuloForm);
    } else {
      final articuloForm = ArticuloForm.fromJson(formArticulo.value);
      updateFormArray(articuloForm, index);
    }
    return isValid;
  }

  void initializeFormArticulo(String id, String cantidad) {
    final value = {
      'id': id.toString(),
      'cantidad': cantidad.toString(),
    };
    formArticulo.patchValue(value);
  }

  void cleanFormArticulo() {
    formArticulo.reset(removeFocus: true);
  }
}
