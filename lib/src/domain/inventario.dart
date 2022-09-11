import 'package:flutter/material.dart';

class Inventario {
  late int id;
  late String nombre;
  late double costo;

  Inventario({@required id, @required nombre, @required costo}) {
    this.id = id;
    this.nombre = nombre;
    this.costo = costo;
  }

  factory Inventario.fromJson(Map<String, dynamic> json) => Inventario(
        id: json["id"],
        nombre: json["nombre"],
        costo: json["costo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "costo": costo,
      };
}
