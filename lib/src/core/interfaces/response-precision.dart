import 'package:flutter/material.dart';
import '../../domain/precision.dart';

class ResponsePrecision {
  late bool status;
  late String message;
  late List<Precision> data;

  ResponsePrecision({
    @required status,
    @required message,
    @required data,
  }) {
    this.status = status;
    this.message = message;
    this.data = data;
  }

  ResponsePrecision.fromJsonMap(Map<String, dynamic> json) {
    status = json['status'];
    data = List<Precision>.from(json["data"].map((x) => Precision.fromJson(x)));
    message = json['message'];
  }
  ResponsePrecision.fromJsonMapSuccess(String mensaje) {
    status = true;
    message = mensaje;
  }

  ResponsePrecision.fromJsonMapError(String mensaje) {
    status = false;
    message = mensaje;
  }
}
