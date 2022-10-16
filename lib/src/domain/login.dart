import 'package:controlinventario/src/domain/rol.dart';
import 'package:flutter/material.dart';

class Login {
  late String nombre;
  late String direccion;
  late String usuario;
  late String rol;
  late String token;

  Login(
      {@required nombre,
      @required direccion,
      @required usuario,
      @required rol,
      @required token}) {
    this.nombre = nombre;
    this.direccion = direccion;
    this.usuario = usuario;
    this.rol = rol;
    this.token = token;
  }

  factory Login.fromJson(Map<String, dynamic> json) => Login(
        nombre: json["nombre"],
        direccion: json["direccion"],
        usuario: json["usuario"],
        rol: json["rol"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "direccion": direccion,
        "usuario": usuario,
        "rol": rol,
        "token": token,
      };
}
