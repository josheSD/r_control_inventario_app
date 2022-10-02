import 'package:controlinventario/src/core/interfaces/response-almacen.dart';
import 'package:controlinventario/src/infraestructure/almacen_service.dart';
import 'package:flutter/material.dart';

class AlmacenProvider with ChangeNotifier {
  AlmacenService _almacenService = new AlmacenService();

  Future<ResponseAlmacen> getAlmacenes() async{

    ResponseAlmacen response = await _almacenService.getAlmacenes();
    return response;

  }


}
