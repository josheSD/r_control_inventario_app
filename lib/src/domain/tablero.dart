import 'package:flutter/material.dart';

class Tablero {
  late int id;
  late String nombre;

  Tablero({@required id, @required nombre}) {
    this.id = id;
    this.nombre = nombre;
  }

  factory Tablero.fromJson(Map<String, dynamic> json) => Tablero(
        id: json["id"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
      };
}