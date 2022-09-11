import 'package:controlinventario/src/domain/tipo.dart';
import 'package:flutter/material.dart';

class ResponseTipoInventario {
  late bool status;
  late String message;
  late List<TipoInventario> data;

  ResponseTipoInventario({
    @required status,
    @required message,
    @required data,
  }){
    this.status = status;
    this.message = message;
    this.data = data;
  }

  ResponseTipoInventario.fromJsonMap(Map<String, dynamic> json) {
    status = json['status'];
    data =
        List<TipoInventario>.from(json["data"].map((x) => TipoInventario.fromJson(x)));
    message = json['message'];
  }

  ResponseTipoInventario.fromJsonMapError(String message) {
    status = false;
    message = message;
  }
}
