import 'package:controlinventario/src/core/interfaces/response-almacen.dart';
import 'package:controlinventario/src/domain/almacen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../core/util/constantes.dart';

class AlmacenService {
  Future<ResponseAlmacen> getAlmacenes() async {
    try {
      final url = "${Envinronment.API_INVENTARIO}/almacen/listar";
      final response = await http.get(Uri.parse(url));

      final decodedResp = json.decode(response.body);

      if (response.statusCode == 200) {
        return new ResponseAlmacen.fromJsonMap(decodedResp);
      } else {
        return new ResponseAlmacen.fromJsonMapError("Error al buscar");
      }
    } catch (e) {
      return new ResponseAlmacen.fromJsonMapError("Error al buscar");
    }
  }

  Future<ResponseAlmacen> postAlmacen(Map<String, dynamic> almacen) async {
    try {

      final url = "${Envinronment.API_INVENTARIO}/almacen/guardar";

      final request = {
        "nombre": almacen["nombre"],
        "direccion": almacen["direccion"],
        "articulo": almacen["articulos"],
      };

      final response =
          await http.post(Uri.parse(url), body: jsonEncode(request));

      final decodedResp = json.decode(response.body);

      if (response.statusCode < 400) {
        return new ResponseAlmacen.fromJsonMapSuccess(decodedResp["message"]);
      } else {
        return new ResponseAlmacen.fromJsonMapError(decodedResp["message"]);
      }
    } catch (e) {
      return new ResponseAlmacen.fromJsonMapError("Error");
    }
  }

  Future<ResponseAlmacen> putAlmacen(Map<String, dynamic> almacen) async {
    try {

      final url = "${Envinronment.API_INVENTARIO}/almacen/editar";

      final request = {
        "id": almacen["id"],
        "nombre": almacen["nombre"],
        "direccion": almacen["direccion"],
        "articulo": almacen["articulos"],
      };

      final response =
          await http.put(Uri.parse(url), body: jsonEncode(request));

      final decodedResp = json.decode(response.body);

      if (response.statusCode < 400) {
        return new ResponseAlmacen.fromJsonMapSuccess(decodedResp["message"]);
      } else {
        return new ResponseAlmacen.fromJsonMapError(decodedResp["message"]);
      }
    } catch (e) {
      return new ResponseAlmacen.fromJsonMapError("Error");
    }
  }

  Future<ResponseAlmacen> deleteAlmacen(int idAlmacen) async {
    try {
      final url =
          "${Envinronment.API_INVENTARIO}/almacen/eliminar?IdAlmacen=$idAlmacen";
      final response = await http.delete(Uri.parse(url));

      final decodedResp = json.decode(response.body);

      if (response.statusCode < 400) {
        return new ResponseAlmacen.fromJsonMap(decodedResp);
      } else {
        return new ResponseAlmacen.fromJsonMapError("Error");
      }
    } catch (e) {
      return new ResponseAlmacen.fromJsonMapError("Error");
    }
  }
}
