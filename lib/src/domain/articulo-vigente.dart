import 'package:flutter/material.dart';

class ArticuloVigente {
  late dynamic id;
  late dynamic cantidad;
  late dynamic idAlmacen;
  late dynamic buena;
  late dynamic daniado;

  ArticuloVigente(
      {@required id,
      @required cantidad,
      @required idAlmacen,
      @required buena,
      @required daniado}) {
    this.id = id;
    this.cantidad = cantidad;
    this.idAlmacen = idAlmacen;
    this.buena = buena;
    this.daniado = daniado;
  }

  factory ArticuloVigente.fromJson(Map<String, dynamic> json) =>
      ArticuloVigente(
        id: json["id"],
        cantidad: json["cantidad"],
        idAlmacen: json["idAlmacen"],
        buena: json["buena"],
        daniado: json["daniado"],
      );
}
