import 'package:flutter/material.dart';

class Categoria {
  late int id;
  late String nombre;

  Categoria({@required id, @required nombre}) {
    this.id = id;
    this.nombre = nombre;
  }

  factory Categoria.fromJson(Map<String, dynamic> json) => Categoria(
        id: json["id"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
      };
}
