import 'package:flutter/material.dart';
import 'articulo-vigente.dart';

class ProductoVigente {
  late List<ArticuloVigente> articulo;

  ProductoVigente({@required articulo}) {
    this.articulo = articulo;
  }

  factory ProductoVigente.fromJson(Map<String, dynamic> json) =>
      ProductoVigente(
          articulo: List<ArticuloVigente>.from(
              json["articulos"].map((x) => ArticuloVigente.fromJson(x))));
}
