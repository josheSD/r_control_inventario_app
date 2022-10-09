import 'package:controlinventario/src/domain/articulo.dart';
import 'package:flutter/material.dart';

class AlmacenForm {
  late dynamic id;
  late dynamic nombre;
  late dynamic direccion;
  late dynamic articulo;

  AlmacenForm(
      {@required id,
      @required nombre,
      @required direccion,
      @required articulo}) {
    this.id = id;
    this.nombre = nombre;
    this.direccion = direccion;
    this.articulo = articulo;
  }

  factory AlmacenForm.fromJson(Map<String, dynamic> json) => AlmacenForm(
      id: json["id"],
      nombre: json["nombre"],
      direccion: json["direccion"],
      articulo: List<Articulo>.from(
          json["articulo"].map((x) => Articulo.fromJson(x))));
}
