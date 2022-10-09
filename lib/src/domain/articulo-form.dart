import 'package:flutter/material.dart';

class ArticuloForm {
  late dynamic idArticulo;
  late dynamic cantidad;
  late dynamic idAlmacen;

  ArticuloForm(
      {@required idArticulo, @required cantidad, @required idAlmacen}) {
    this.idArticulo = idArticulo;
    this.cantidad = cantidad;
    this.idAlmacen = idAlmacen;
  }

  factory ArticuloForm.fromJson(Map<String, dynamic> json) => ArticuloForm(
        idArticulo: json["idArticulo"],
        cantidad: json["cantidad"],
        idAlmacen: json["idAlmacen"],
      );
}
