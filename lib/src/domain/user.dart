import 'package:flutter/material.dart';

class Usuario {
  Usuario({@required usuario, @required correo}) {
    this.usuario = usuario;
    this.correo = correo;
  }

  late String usuario;
  late String correo;

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        usuario: json["usuario"],
        correo: json["correo"],
      );

  Map<String, dynamic> toJson() => {
        "usuario": usuario,
        "correo": correo,
      };
}
