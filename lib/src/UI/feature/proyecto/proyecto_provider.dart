import 'package:controlinventario/src/core/interfaces/response-almacen.dart';
import 'package:controlinventario/src/core/interfaces/response-proyecto.dart';
import 'package:controlinventario/src/infraestructure/proyecto_service.dart';
import 'package:flutter/material.dart';

class ProyectoProvider with ChangeNotifier {
  ProyectoService _proyectoService = new ProyectoService();

  Future<ResponseProyecto> getProyectos() async{

    ResponseProyecto response = await _proyectoService.getProyectos();
    return response;

  }


}
