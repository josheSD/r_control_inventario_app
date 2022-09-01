import 'package:flutter/material.dart';

class Auth {
  Auth({@required usuario, @required contrasenia}) {
    this.usuario = usuario;
    this.contrasenia = contrasenia;
  }
  late String usuario;
  late String contrasenia;

  factory Auth.fromJson(Map<String, dynamic> json) => Auth(
        usuario: json["usuario"],
        contrasenia: json["contrasenia"],
      );

  Map<String, dynamic> toJson() => {
        "usuario": usuario,
        "contrasenia": contrasenia,
      };
}
