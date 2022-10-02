import 'package:flutter/material.dart';

class Rol {
  late int id;
  late String nombre;

  Rol({@required id, @required nombre}) {
    this.id = id;
    this.nombre = nombre;
  }

  factory Rol.fromJson(Map<String, dynamic> json) => Rol(
        id: json["id"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
      };
}

enum ERol {
  ADMINISTRADOR,
  ALMACENERO,
}
