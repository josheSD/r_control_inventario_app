import 'package:controlinventario/src/domain/usuario.dart';
import 'package:flutter/material.dart';

class ResponseUsuario {
  late bool status;
  late String message;
  late List<Usuario> data;

  ResponseUsuario({
    @required status,
    @required message,
    @required data,
  }){
    this.status = status;
    this.message = message;
    this.data = data;
  }

  ResponseUsuario.fromJsonMap(Map<String, dynamic> json) {
    status = json['status'];
    data = List<Usuario>.from(json["data"].map((x) => Usuario.fromJson(x)));
    message = json['message'];
  }

  ResponseUsuario.fromJsonMapError(String message) {
    status = false;
    message = message;
  }
}
