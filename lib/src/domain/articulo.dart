import 'package:controlinventario/src/domain/categoria.dart';
import 'package:flutter/material.dart';

class Articulo {
  late int id;
  late String url;
  late String nombre;
  late Categoria categoria;
  late String precio;
  late dynamic fechaCreacion;
  late dynamic fechaActualizacion;
  late dynamic almacen; // Almacen or null
  late dynamic cantidad;

  Articulo({@required id, @required url,@required nombre, @required categoria, @required precio,@required fechaCreacion,@required fechaActualizacion,@required almacen, @required cantidad}) {
    this.id = id;
    this.url = url;
    this.nombre = nombre;
    this.categoria = categoria;
    this.precio = precio;
    this.fechaCreacion = fechaCreacion;
    this.fechaActualizacion = fechaActualizacion;
    this.almacen = almacen;
    this.cantidad = cantidad;
  }

  factory Articulo.fromJson(Map<String, dynamic> json) => Articulo(
        id: json["id"],
        url: json["url"],
        nombre: json["nombre"],
        categoria: Categoria.fromJson(json["categoria"]),
        precio: json["precio"],
        fechaCreacion: json["fechaCreacion"],
        fechaActualizacion: json["fechaActualizacion"],
        almacen: json["almacen"],
        cantidad: json["cantidad"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "nombre": nombre,
        "categoria": categoria,
        "precio": precio,
        "fechaCreacion": fechaCreacion,
        "fechaActualizacion": fechaActualizacion,
        "almacen": almacen,
        "cantidad": cantidad,
      };
}
