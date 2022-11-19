import 'package:controlinventario/src/domain/categoria.dart';
import 'package:flutter/material.dart';

class RotacionArticulo {
  late int idArticulo;
  late String nombreArticulo;
  late int unidadSalida;
  late int unidadStock;
  late String rotacion;

  RotacionArticulo(
      {@required idArticulo,
      @required nombreArticulo,
      @required unidadSalida,
      @required unidadStock,
      @required rotacion}) {
    this.idArticulo = idArticulo;
    this.nombreArticulo = nombreArticulo;
    this.unidadSalida = unidadSalida;
    this.unidadStock = unidadStock;
    this.rotacion = rotacion;
  }

  factory RotacionArticulo.fromJson(Map<String, dynamic> json) =>
      RotacionArticulo(
        idArticulo: json["idArticulo"],
        nombreArticulo: json["nombreArticulo"],
        unidadSalida: json["unidadSalida"],
        unidadStock: json["unidadStock"],
        rotacion: json["rotacion"],
      );
}
