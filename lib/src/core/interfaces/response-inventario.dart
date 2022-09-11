import 'package:controlinventario/src/domain/inventario.dart';
import 'package:flutter/material.dart';

class ResponseInventario {
  late bool status;
  late String message;
  late List<Inventario> data;

  ResponseInventario({
    @required status,
    @required message,
    @required data,
  }){
    this.status = status;
    this.message = message;
    this.data = data;
  }

  ResponseInventario.fromJsonMap(Map<String, dynamic> json) {
    status = json['status'];
    data =
        List<Inventario>.from(json["data"].map((x) => Inventario.fromJson(x)));
    message = json['message'];
  }

  ResponseInventario.fromJsonMapError(String message) {
    status = false;
    message = message;
  }
}
