import 'dart:convert';

import 'package:controlinventario/src/core/util/constantes.dart';
import 'package:http/http.dart' as http;

import '../core/interfaces/response-precision.dart';
import '../core/interfaces/response-rotacion.dart';

class TableroService {
  Future<ResponsePrecision> getPrecisiones() async {
    try {
      final url = "${Envinronment.API_INVENTARIO}/proyecto/precisioninventario";
      final response = await http.get(Uri.parse(url));

      final decodedResp = json.decode(response.body);

      if (response.statusCode < 400) {
        return new ResponsePrecision.fromJsonMap(decodedResp);
      } else {
        return new ResponsePrecision.fromJsonMapError("Error al buscar");
      }
    } catch (e) {
      return new ResponsePrecision.fromJsonMapError("Error al buscar");
    }
  }

  Future<ResponseRotacion> getRotaciones() async {
    try {
      final url = "${Envinronment.API_INVENTARIO}/proyecto/rotacioninventario";
      final response = await http.get(Uri.parse(url));

      final decodedResp = json.decode(response.body);

      if (response.statusCode < 400) {
        return new ResponseRotacion.fromJsonMap(decodedResp);
      } else {
        return new ResponseRotacion.fromJsonMapError("Error al buscar");
      }
    } catch (e) {
      return new ResponseRotacion.fromJsonMapError("Error al buscar");
    }
  }
}
