import 'package:controlinventario/src/domain/articulo.dart';
import 'package:flutter/material.dart';

class Almacen {
  late int id;
  late String nombre;
  late String direccion;
  late List<Articulo> articulo;
  late dynamic fechaCreacion;
  late dynamic fechaActualizacion;

  Almacen(
      {@required id,
      @required nombre,
      @required direccion,
      @required articulo,
      @required fechaCreacion,
      @required fechaActualizacion}) {
    this.id = id;
    this.nombre = nombre;
    this.direccion = direccion;
    this.articulo = articulo;
    this.fechaCreacion = fechaCreacion;
    this.fechaActualizacion = fechaActualizacion;
  }

  factory Almacen.fromJson(Map<String, dynamic> json) => Almacen(
      id: json["id"],
      nombre: json["nombre"],
      direccion: json["direccion"],
      articulo: List<Articulo>.from(
          json["articulo"].map((x) => Articulo.fromJson(x))),
      fechaCreacion: json["fechaCreacion"],
      fechaActualizacion: json["fechaActualizacion"]
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "direccion": direccion,
        "categoria": articulo,
        "fechaCreacion": fechaCreacion,
        "fechaActualizacion": fechaActualizacion
      };
}
