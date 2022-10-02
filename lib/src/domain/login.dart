import 'package:flutter/material.dart';

class Login {

  late String usario;
  late String correo;

  Login({@required usario, @required correo}) {
    this.usario = usario;
    this.correo = correo;
  }

  factory Login.fromJson(Map<String, dynamic> json) => Login(
        usario: json["usario"],
        correo: json["correo"],
      );

  Map<String, dynamic> toJson() => {
        "usario": usario,
        "correo": correo,
      };
}
