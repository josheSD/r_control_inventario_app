import 'package:flutter/material.dart';

class TipoInventario {
  late int id;
  late String nombre;

  TipoInventario({@required id, @required nombre}) {
    this.id = id;
    this.nombre = nombre;
  }

  factory TipoInventario.fromJson(Map<String, dynamic> json) => TipoInventario(
        id: json["id"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
      };
}
