import 'package:controlinventario/src/domain/proyecto.dart';
import 'package:controlinventario/src/domain/tipo.dart';
import 'package:flutter/material.dart';

class ResponseProyecto {
  late bool status;
  late String message;
  late List<Proyecto> data;

  ResponseProyecto({
    @required status,
    @required message,
    @required data,
  }) {
    this.status = status;
    this.message = message;
    this.data = data;
  }

  ResponseProyecto.fromJsonMap(Map<String, dynamic> json) {
    status = json['status'];
    data = List<Proyecto>.from(json["data"].map((x) => Proyecto.fromJson(x)));
    message = json['message'];
  }

  ResponseProyecto.fromJsonMapError(String message) {
    status = false;
    message = message;
  }
}
