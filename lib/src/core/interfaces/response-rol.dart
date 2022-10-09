import 'package:controlinventario/src/domain/rol.dart';
import 'package:flutter/material.dart';

class ResponseRol {
  late bool status;
  late String message;
  late List<Rol> data;

  ResponseRol({
    @required status,
    @required message,
    @required data,
  }){
    this.status = status;
    this.message = message;
    this.data = data;
  }

  ResponseRol.fromJsonMap(Map<String, dynamic> json) {
    status = json['status'];
    data = List<Rol>.from(json["data"].map((x) => Rol.fromJson(x)));
    message = json['message'];
  }

  ResponseRol.fromJsonMapError(String message) {
    status = false;
    message = message;
  }
}
