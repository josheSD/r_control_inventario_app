import 'package:controlinventario/src/domain/articulo.dart';
import 'package:flutter/material.dart';

class Proyecto {
  late int id;
  late String nombre;
  late String cliente;
  late String fechaInicio;
  late String fechaFin;
  late String contrato;
  late List<Articulo> articulo;
  late int estado;
  late dynamic fechaCreacion;
  late dynamic fechaActualizacion;

  Proyecto(
      {@required id,
      @required nombre,
      @required cliente,
      @required fechaInicio,
      @required fechaFin,
      @required contrato,
      @required articulo,
      @required estado,
      @required fechaCreacion,
      @required fechaActualizacion}) {
    this.id = id;
    this.nombre = nombre;
    this.cliente = cliente;
    this.fechaInicio = fechaInicio;
    this.fechaFin = fechaFin;
    this.contrato = contrato;
    this.articulo = articulo;
    this.estado = estado;
    this.fechaCreacion = fechaCreacion;
    this.fechaActualizacion = fechaActualizacion;
  }

  factory Proyecto.fromJson(Map<String, dynamic> json) => Proyecto(
      id: json["id"],
      nombre: json["nombre"],
      cliente: json["cliente"],
      fechaInicio: json["fechaInicio"],
      fechaFin: json["fechaFin"],
      contrato: json["contrato"],
      articulo: List<Articulo>.from(
          json["articulo"].map((x) => Articulo.fromJson(x))),
      estado: json["estado"],
      fechaCreacion: json["fechaCreacion"],
      fechaActualizacion: json["fechaActualizacion"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "cliente": cliente,
        "fechaInicio": fechaInicio,
        "fechaFin": fechaFin,
        "contrato": contrato,
        "articulo": articulo,
        "estado": estado,
        "fechaCreacion": fechaCreacion,
        "fechaActualizacion": fechaActualizacion
      };
}

enum EProyecto {
  VIGENTE,
  CONCLUIDO,
}
