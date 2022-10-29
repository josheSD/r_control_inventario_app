import 'package:flutter/material.dart';

class ResponseImagen {
  late bool status;
  late String message;
  late String data;

  ResponseImagen({
    @required status,
    @required message,
    @required data,
  }){
    this.status = status;
    this.message = message;
    this.data = data;
  }

  ResponseImagen.fromJsonMap(String nombre) {
    status = true;
    data = nombre;
  }

  ResponseImagen.fromJsonMapError(String mensaje) {
    status = false;
    message = mensaje;
  }
}
