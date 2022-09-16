import 'dart:io';

import 'package:controlinventario/src/core/interfaces/response-tipo-inventario.dart';
import 'package:controlinventario/src/infraestructure/inventario_service.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class InventarioCrearProvider with ChangeNotifier {
  InventarioService _inventarioService = new InventarioService();

  FormGroup form = new FormGroup({
    'foto': FormControl<File>(value: null, validators: [Validators.required]),
    'tipo': FormControl<String>(value: '', validators: [Validators.required]),
    'nombre': FormControl<String>(value: '', validators: [Validators.required]),
    'precio': FormControl<String>(value: '', validators: [Validators.required]),
  });

  Future<ResponseTipoInventario> getTipoInventario() async {
    ResponseTipoInventario response =
        await _inventarioService.getTipoInventario();
    return response;
  }
  Future<void> handlerSubmit(BuildContext context) async {
    if (form.invalid) {
      form.markAllAsTouched();
      return;
    }
  }
}
