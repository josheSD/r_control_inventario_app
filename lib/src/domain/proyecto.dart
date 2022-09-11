import 'package:flutter/material.dart';

class Proyecto {
  late int id;
  late String nombre;

  Proyecto({@required id, @required nombre}) {
    this.id = id;
    this.nombre = nombre;
  }

  factory Proyecto.fromJson(Map<String, dynamic> json) => Proyecto(
        id: json["id"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
      };
}
