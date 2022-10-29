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
import '../../../domain/articulo.dart';
import '../../../domain/producto-vigente.dart';

class ProyectoProvider with ChangeNotifier {
  ProyectoService _proyectoService = new ProyectoService();

  FormGroup form = new FormGroup({
    'id': FormControl<String>(value: ''),
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
      'id': FormControl<String>(
          value: articuloForm.id, validators: [Validators.required]),
      'cantidad': FormControl<String>(
          value: articuloForm.cantidad, validators: [Validators.required]),
    }));
  }

  updateFormArray(ArticuloForm articuloForm, index) async {
    final value = {
      'idAlmacen': articuloForm.idAlmacen,
      'id': articuloForm.id,
      'cantidad': articuloForm.cantidad
    };
    articulosList.controls[index].patchValue(value);

    final newLista = articulosList.controls.map((e) => FormGroup({
          'idAlmacen': FormControl<String>(
              value: ArticuloForm.fromJson(e.value).idAlmacen,
              validators: [Validators.required]),
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

    late ResponseProyecto response;
    if (form.value["id"].toString().length > 0 &&
        form.value["id"].toString() != 'null') {
      response = await _proyectoService.putProyecto(form.value);
    } else {
      response = await _proyectoService.postProyecto(form.value);
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

      Navigator.pushReplacementNamed(context, Routes.PROYECTO);
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

  void initializeForm(Proyecto proyecto) {
    final value = {
      'id': proyecto.id.toString(),
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

  Future<ResponseProyecto> getProyectos() async {
    ResponseProyecto response = await _proyectoService.getProyectos();
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

  void initializeFormArticulo(
      String idAlmacen, String idArticulo, String cantidad) {
    final value = {
      'idAlmacen': idAlmacen.toString(),
      'id': idArticulo.toString(),
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

  FormArray get articuloConcluidos =>
      formConcluido.control('articulos') as FormArray;

  void initializeFormConcluido() {
    final newLista = articulosList.controls.map((e) => FormGroup({
          'id': FormControl<String>(value: ArticuloForm.fromJson(e.value).id),
          'cantidad': FormControl<String>(
              value: ArticuloForm.fromJson(e.value).cantidad),
          'idAlmacen': FormControl<String>(
              value: ArticuloForm.fromJson(e.value).idAlmacen),
          'buena':
              FormControl<String>(value: "", validators: [Validators.required]),
          'daniado':
              FormControl<String>(value: "", validators: [Validators.required]),
        }));

    articuloConcluidos.clear();
    articuloConcluidos.addAll(newLista.toList());
  }

  Future<void> handleSubmitConcluido(BuildContext context) async {
    if (formConcluido.invalid) {
      formConcluido.markAllAsTouched();
      return;
    }

    bool esDiferente = false;
    Map<String, dynamic> formMain = form.value;
    String idProyecto = formMain["id"];

    ProductoVigente producto = ProductoVigente.fromJson(formConcluido.value);

    for (int i = 0; i < producto.articulo.length; i++) {
      int buena = int.parse(producto.articulo[i].buena);
      int daniado = int.parse(producto.articulo[i].daniado);
      int total = buena + daniado;
      int cantidad = int.parse(producto.articulo[i].cantidad);
      if (total != cantidad) {
        esDiferente = true;
        break;
      }
    }

    if (esDiferente) {
      SnackBar snackBar = SnackBar(
          content: Text("Por favor, valide la cantidad",
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
      return;
    }

    ResponseProyecto response = await this._proyectoService.putVigenteProyecto(idProyecto, formConcluido.value);

    if (response.status) {
      this.formConcluido.reset(removeFocus: true);

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

      Navigator.pushNamed(context, Routes.PROYECTO);
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

  void cleanFormConcluido() {
    articuloConcluidos.clear();
    formConcluido.reset(removeFocus: true);
  }
}
