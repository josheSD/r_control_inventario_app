
import 'package:controlinventario/src/domain/articulo.dart';
import 'package:flutter/material.dart';

class ResponseArticulo {
  late bool status;
  late String message;
  late List<Articulo> data;

  ResponseArticulo({
    @required status,
    @required message,
    @required data,
  }){
    this.status = status;
    this.message = message;
    this.data = data;
  }

  ResponseArticulo.fromJsonMap(Map<String, dynamic> json) {
    status = json['status'];
    data =
        List<Articulo>.from(json["data"].map((x) => Articulo.fromJson(x)));
    message = json['message'];
  }

  ResponseArticulo.fromJsonMapError(String message) {
    status = false;
    message = message;
  }
}
