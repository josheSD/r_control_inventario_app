import 'package:controlinventario/src/domain/usuario.dart';
import 'package:flutter/material.dart';

class Response {
  late bool status;
  late String message;

  Response({
    @required status,
    @required message,
  }){
    this.status = status;
    this.message = message;
  }

  Response.fromJsonMapError(bool status,String message) {
    status = status;
    message = message;
  }
}
