import 'package:controlinventario/src/domain/rol.dart';
import 'package:flutter/material.dart';

class Usuario {
  late int id;
  late String nombre;
  late String direccion;
  late String usuario;
  late String contrasenia;
  late Rol rol;

  Usuario(
      {@required id,
      @required nombre,
      @required direccion,
      @required usuario,
      @required contrasenia,
      @required rol}) {
    this.id = id;
    this.nombre = nombre;
    this.direccion = direccion;
    this.usuario = usuario;
    this.contrasenia = contrasenia;
    this.rol = rol;
  }

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        id: json["id"],
        nombre: json["nombre"],
        direccion: json["direccion"],
        usuario: json["usuario"],
        contrasenia: json["contrasenia"],
        rol: Rol.fromJson(json["rol"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "direccion": direccion,
        "usuario": usuario,
        "contrasenia": contrasenia,
        "rol": rol,
      };
}


