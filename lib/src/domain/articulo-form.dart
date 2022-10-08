import 'package:flutter/material.dart';

class ArticuloForm {
  late dynamic idArticulo;
  late dynamic cantidad;

  ArticuloForm({@required idArticulo, @required cantidad}) {
    this.idArticulo = idArticulo;
    this.cantidad = cantidad;
  }

  factory ArticuloForm.fromJson(Map<String, dynamic> json) => ArticuloForm(
        idArticulo: json["idArticulo"],
        cantidad: json["cantidad"],
      );

}
