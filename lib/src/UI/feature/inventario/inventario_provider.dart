import 'package:controlinventario/src/core/interfaces/response-inventario.dart';
import 'package:controlinventario/src/infraestructure/inventario_service.dart';
import 'package:flutter/material.dart';

class InventarioProvider with ChangeNotifier {
  InventarioService _inventarioService = new InventarioService();

  Future<ResponseInventario> getInventarios() async{

    ResponseInventario response = await _inventarioService.getInventarios();
    return response;

  }


}
