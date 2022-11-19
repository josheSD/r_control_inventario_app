import 'package:flutter/material.dart';
import '../../domain/rotacion.dart';

class ResponseRotacion {
  late bool status;
  late String message;
  late List<Rotacion> data;

  ResponseRotacion({
    @required status,
    @required message,
    @required data,
  }) {
    this.status = status;
    this.message = message;
    this.data = data;
  }

  ResponseRotacion.fromJsonMap(Map<String, dynamic> json) {
    status = json['status'];
    data = List<Rotacion>.from(json["data"].map((x) => Rotacion.fromJson(x)));
    message = json['message'];
  }
  ResponseRotacion.fromJsonMapSuccess(String mensaje) {
    status = true;
    message = mensaje;
  }

  ResponseRotacion.fromJsonMapError(String mensaje) {
    status = false;
    message = mensaje;
  }
}
