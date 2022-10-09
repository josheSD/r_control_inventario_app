import 'package:controlinventario/src/core/interfaces/response-proyecto.dart';
import 'package:controlinventario/src/core/util/constantes.dart';
import 'package:controlinventario/src/core/util/routes.dart';
import 'package:controlinventario/src/domain/articulo-form.dart';
import 'package:controlinventario/src/domain/proyecto.dart';
import 'package:controlinventario/src/infraestructure/proyecto_service.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../domain/almacen-form.dart';
import '../../../domain/almacen.dart';

class ProyectoProvider with ChangeNotifier {
  ProyectoService _proyectoService = new ProyectoService();

  FormGroup form = new FormGroup({
    'nombre': FormControl<String>(value: '', validators: [Validators.required]),
    'cliente':
        FormControl<String>(value: '', validators: [Validators.required]),
    'fechaInicio':
        FormControl<String>(value: '', validators: [Validators.required]),
    'fechaFin':
        FormControl<String>(value: '', validators: [Validators.required]),
    'articulos': FormArray([], validators: [Validators.required])
  });

  FormArray get articulosList => form.control('articulos') as FormArray;

  addFormArray(ArticuloForm articuloForm) async {
    articulosList.add(FormGroup({
      'idAlmacen': FormControl<String>(
          value: articuloForm.idAlmacen, validators: [Validators.required]),
      'idArticulo': FormControl<String>(
          value: articuloForm.idArticulo, validators: [Validators.required]),
      'cantidad': FormControl<String>(
          value: articuloForm.cantidad, validators: [Validators.required]),
    }));
  }

  updateFormArray(ArticuloForm articuloForm, index) async {
    final value = {
      'idAlmacen': articuloForm.idAlmacen,
      'idArticulo': articuloForm.idArticulo,
      'cantidad': articuloForm.cantidad
    };
    articulosList.controls[index].patchValue(value);

    final newLista = articulosList.controls.map((e) => FormGroup({
          'idAlmacen': FormControl<String>(
              value: ArticuloForm.fromJson(e.value).idAlmacen,
              validators: [Validators.required]),
          'idArticulo': FormControl<String>(
              value: ArticuloForm.fromJson(e.value).idArticulo,
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

    if (isValidArticulos) {
      Navigator.pushNamed(context, Routes.PROYECTO);
    }
  }

  void initializeForm(Proyecto proyecto) {
    final value = {
      'nombre': proyecto.nombre,
      'cliente': proyecto.cliente,
      'fechaInicio': proyecto.fechaInicio,
      'fechaFin': proyecto.fechaFin,
    };
    form.patchValue(value);

    final newLista = proyecto.articulo.map((e) => FormGroup({
          'idAlmacen': FormControl<String>(
              value: AlmacenForm.fromJson(e.almacen).id.toString(),
              validators: [Validators.required]),
          'idArticulo': FormControl<String>(
              value: e.categoria.id.toString(),
              validators: [Validators.required]),
          'cantidad': FormControl<String>(
              value: e.cantidad.toString(), validators: [Validators.required]),
        }));

    articulosList.addAll(newLista.toList());
  }

  void cleanForm() {
    articulosList.clear();
    form.reset(removeFocus: true);
  }

  Future<ResponseProyecto> getProyectos() async {
    ResponseProyecto response = await _proyectoService.getProyectos();
    return response;
  }

  Future<ResponseProyecto> postProyecto(Proyecto proyecto) async {
    ResponseProyecto response = await _proyectoService.postProyecto(proyecto);
    return response;
  }

  Future<ResponseProyecto> putProyecto(Proyecto proyecto) async {
    ResponseProyecto response = await _proyectoService.putProyecto(proyecto);
    return response;
  }

  Future<ResponseProyecto> deleteProyecto(int idProyecto) async {
    ResponseProyecto response =
        await _proyectoService.deleteProyecto(idProyecto);
    return response;
  }

  // ###############    Form Articulo   #########################
  FormGroup formArticulo = new FormGroup({
    'idAlmacen':
        FormControl<String>(value: '', validators: [Validators.required]),
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
      final articuloForm = ArticuloForm.fromJson(formArticulo.value);
      addFormArray(articuloForm);
    } else {
      final articuloForm = ArticuloForm.fromJson(formArticulo.value);
      updateFormArray(articuloForm, index);
    }
    return isValid;
  }

  void initializeFormArticulo(
      String idAlmacen, String idArticulo, String cantidad) {
    final value = {
      'idAlmacen': idAlmacen.toString(),
      'idArticulo': idArticulo.toString(),
      'cantidad': cantidad.toString(),
    };
    formArticulo.patchValue(value);
  }

  void cleanFormArticulo() {
    formArticulo.reset(removeFocus: true);
  }

  // ##############     PROYECTO CONCLUIDO   ###############
  FormGroup formConcluido = new FormGroup({
    'articulos': FormArray([], validators: [Validators.required])
  });

  addFormArrayConcluido() async {
    articuloConcluidos.add(FormGroup({
      'idArticulo': FormControl<String>(
          value: 'Sierra Circular', validators: [Validators.required]),
      'buena':
          FormControl<String>(value: '', validators: [Validators.required]),
      'daniado':
          FormControl<String>(value: '', validators: [Validators.required]),
    }));
  }

  FormArray get articuloConcluidos => form.control('articulos') as FormArray;

  Future<void> handleSubmitConcluido(BuildContext context) async {
    bool isValidArticulos = true;

    if (articuloConcluidos.controls.length == 0) {
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

    if (isValidArticulos) {
      Navigator.pushNamed(context, Routes.PROYECTO);
    }
  }

  void cleanFormConcluido() {
    articuloConcluidos.clear();
    articuloConcluidos.reset(removeFocus: true);
  }
}
