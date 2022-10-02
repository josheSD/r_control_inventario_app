import 'package:controlinventario/src/core/interfaces/response-articulo.dart';
import 'package:controlinventario/src/infraestructure/articulo_service.dart';
import 'package:flutter/material.dart';

class ArticuloProvider with ChangeNotifier {
  ArticuloService _articuloService = new ArticuloService();

  Future<ResponseArticulo> getArticulos() async{

    ResponseArticulo response = await _articuloService.getArticulos();
    return response;

  }


}
