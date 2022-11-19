import 'package:controlinventario/src/domain/rotacion-articulo.dart';
import 'package:flutter/material.dart';

class Rotacion {
  late int idAlmacen;
  late String almacen;
  late List<RotacionArticulo> articulos;

  Rotacion({@required idAlmacen, @required almacen, @required articulos}) {
    this.idAlmacen = idAlmacen;
    this.almacen = almacen;
    this.articulos = articulos;
  }

  factory Rotacion.fromJson(Map<String, dynamic> json) => Rotacion(
      idAlmacen: json["idAlmacen"],
      almacen: json["almacen"],
      articulos: List<RotacionArticulo>.from(
          json["articulos"].map((x) => RotacionArticulo.fromJson(x))));
}
