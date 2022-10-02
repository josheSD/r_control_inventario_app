import 'package:controlinventario/src/domain/articulo.dart';
import 'package:flutter/material.dart';

class Almacen {
  late int id;
  late String nombre;
  late String direccion;
  late List<Articulo> articulo;

  Almacen(
      {@required id,
      @required nombre,
      @required direccion,
      @required articulo}) {
    this.id = id;
    this.nombre = nombre;
    this.direccion = direccion;
    this.articulo = articulo;
  }

  factory Almacen.fromJson(Map<String, dynamic> json) => Almacen(
      id: json["id"],
      nombre: json["nombre"],
      direccion: json["direccion"],
      articulo: List<Articulo>.from(
          json["articulo"].map((x) => Articulo.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "direccion": direccion,
        "categoria": articulo,
      };
}
