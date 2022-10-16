
import 'package:controlinventario/src/domain/almacen.dart';
import 'package:flutter/material.dart';

class ResponseAlmacen {
  late bool status;
  late String message;
  List<Almacen>? data;

  ResponseAlmacen({
    @required status,
    @required message,
    @required data,
  }){
    this.status = status;
    this.message = message;
    this.data = data;
  }

  ResponseAlmacen.fromJsonMap(Map<String, dynamic> json) {
    status = json['status'];
    data =
        List<Almacen>.from(json["data"].map((x) => Almacen.fromJson(x)));
    message = json['message'];
  }
  ResponseAlmacen.fromJsonMapSuccess(String mensaje) {
    status = true;
    message = mensaje;
  }

  ResponseAlmacen.fromJsonMapError(String mensaje) {
    status = false;
    message = mensaje;
  }
}
