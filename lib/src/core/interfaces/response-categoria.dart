import 'package:controlinventario/src/domain/categoria.dart';
import 'package:flutter/material.dart';

class ResponseCategoria {
  late bool status;
  late String message;
  late List<Categoria> data;

  ResponseCategoria({
    @required status,
    @required message,
    @required data,
  }){
    this.status = status;
    this.message = message;
    this.data = data;
  }

  ResponseCategoria.fromJsonMap(Map<String, dynamic> json) {
    status = json['status'];
    data =
        List<Categoria>.from(json["data"].map((x) => Categoria.fromJson(x)));
    message = json['message'];
  }

  ResponseCategoria.fromJsonMapError(String message) {
    status = false;
    message = message;
  }
}
