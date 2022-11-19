import 'package:controlinventario/src/domain/precision-articulo.dart';
import 'package:flutter/material.dart';

class Precision {
  late int idAlmacen;
  late String almacen;
  late List<PrecisionArticulo> articulos;

  Precision({@required idAlmacen, @required almacen, @required articulos}) {
    this.idAlmacen = idAlmacen;
    this.almacen = almacen;
    this.articulos = articulos;
  }

  factory Precision.fromJson(Map<String, dynamic> json) => Precision(
      idAlmacen: json["idAlmacen"],
      almacen: json["almacen"],
      articulos: List<PrecisionArticulo>.from(
          json["articulos"].map((x) => PrecisionArticulo.fromJson(x))));
}
