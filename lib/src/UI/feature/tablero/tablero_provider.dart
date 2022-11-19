import 'package:flutter/material.dart';

import '../../../core/interfaces/response-precision.dart';
import '../../../core/interfaces/response-rotacion.dart';
import '../../../infraestructure/tablero_service.dart';

class TableroProvider with ChangeNotifier {
  TableroService _tableroService = new TableroService();

  Future<ResponsePrecision> getPrecisiones() async {
    ResponsePrecision response = await _tableroService.getPrecisiones();
    return response;
  }

  Future<ResponseRotacion> getRotaciones() async {
    ResponseRotacion response = await _tableroService.getRotaciones();
    return response;
  }
}
