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
    'nombre': FormControl<String>(value: '', validators: [Validators.required]),
    'direccion':
        FormControl<String>(value: '', validators: [Validators.required]),
    'articulos': FormArray([], validators: [Validators.required])
  });

  FormArray get articulosList => form.control('articulos') as FormArray;

  addFormArray(ArticuloForm articuloForm) async {
    articulosList.add(FormGroup({
      'idArticulo': FormControl<String>(
          value: articuloForm.idArticulo, validators: [Validators.required]),
      'cantidad': FormControl<String>(
          value: articuloForm.cantidad, validators: [Validators.required]),
    }));
  }

  updateFormArray(ArticuloForm articuloForm, index) async {
    final value = {
      'idArticulo': articuloForm.idArticulo,
      'cantidad': articuloForm.cantidad
    };
    articulosList.controls[index].patchValue(value);
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

    if (isValidArticulos) {
      Navigator.pushNamed(context, Routes.ALMACEN);
    }
  }

  void initializeForm(Almacen almacen) {
    final value = {
      'nombre': almacen.nombre,
      'direccion': almacen.direccion,
      'articulos': almacen.articulo
    };
    form.patchValue(value);
  }

  void cleanForm() {
    form = new FormGroup({
      'nombre':
          FormControl<String>(value: '', validators: [Validators.required]),
      'direccion':
          FormControl<String>(value: '', validators: [Validators.required]),
      'articulos': FormArray([], validators: [Validators.required])
    });
  }

  Future<ResponseAlmacen> getAlmacenes() async {
    ResponseAlmacen response = await _almacenService.getAlmacenes();
    return response;
  }

  Future<ResponseAlmacen> postAlmacen(Almacen almacen) async {
    ResponseAlmacen response = await _almacenService.postAlmacen(almacen);
    return response;
  }

  Future<ResponseAlmacen> putAlmacen(Almacen almacen) async {
    ResponseAlmacen response = await _almacenService.putAlmacen(almacen);
    return response;
  }

  Future<ResponseAlmacen> deleteAlmacen(int idAlmacen) async {
    ResponseAlmacen response = await _almacenService.deleteAlmacen(idAlmacen);
    return response;
  }

  // Form Articulo
  FormGroup formArticulo = new FormGroup({
    'idArticulo':
        FormControl<String>(value: '', validators: [Validators.required]),
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
      print('ENTRE CREATE');
      final articuloForm = ArticuloForm.fromJson(formArticulo.value);
      addFormArray(articuloForm);
    } else {
      print('ENTRE UPDATE');
      final articuloForm = ArticuloForm.fromJson(formArticulo.value);
      updateFormArray(articuloForm,index);
    }
    return isValid;
  }

  void initializeFormArticulo(String idArticulo, String cantidad) {
    final value = {
      'idArticulo': idArticulo.toString(),
      'cantidad': cantidad.toString(),
    };
    formArticulo.patchValue(value);
  }

  void cleanFormArticulo() {
    formArticulo.reset(removeFocus: true);
  }
}
