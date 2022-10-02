import 'package:controlinventario/src/domain/categoria.dart';
import 'package:flutter/material.dart';

class Articulo {
  late int id;
  late String url;
  late String nombre;
  late Categoria categoria;
  late double precio;
  late dynamic almacen; // Almacen or null

  Articulo({@required id, @required url,@required nombre, @required categoria, @required precio,@required almacen}) {
    this.id = id;
    this.url = url;
    this.nombre = nombre;
    this.categoria = categoria;
    this.precio = precio;
    this.almacen = almacen;
  }

  factory Articulo.fromJson(Map<String, dynamic> json) => Articulo(
        id: json["id"],
        url: json["url"],
        nombre: json["nombre"],
        categoria: Categoria.fromJson(json["categoria"]),
        precio: json["precio"],
        almacen: json["almacen"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "nombre": nombre,
        "categoria": categoria,
        "precio": precio,
        "almacen": almacen,
      };
}
