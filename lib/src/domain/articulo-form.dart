import 'package:flutter/material.dart';

class ArticuloForm {
  late dynamic id;
  late dynamic cantidad;
  late dynamic idAlmacen;

  ArticuloForm({@required id, @required cantidad, @required idAlmacen}) {
    this.id = id;
    this.cantidad = cantidad;
    this.idAlmacen = idAlmacen;
  }

  factory ArticuloForm.fromJson(Map<String, dynamic> json) => ArticuloForm(
        id: json["id"],
        cantidad: json["cantidad"],
        idAlmacen: json["idAlmacen"],
      );
}
