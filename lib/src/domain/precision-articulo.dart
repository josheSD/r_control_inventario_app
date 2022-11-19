import 'package:flutter/material.dart';

class PrecisionArticulo {
  late int idArticulo;
  late String nombreArticulo;
  late int totalAnterior;
  late int totalActual;
  late String precision;

  PrecisionArticulo(
      {@required idArticulo,
      @required nombreArticulo,
      @required totalAnterior,
      @required totalActual,
      @required precision}) {
    this.idArticulo = idArticulo;
    this.nombreArticulo = nombreArticulo;
    this.totalAnterior = totalAnterior;
    this.totalActual = totalActual;
    this.precision = precision;
  }

  factory PrecisionArticulo.fromJson(Map<String, dynamic> json) =>
      PrecisionArticulo(
        idArticulo: json["idArticulo"],
        nombreArticulo: json["nombreArticulo"],
        totalAnterior: json["totalAnterior"],
        totalActual: json["totalActual"],
        precision: json["precision"],
      );
}
