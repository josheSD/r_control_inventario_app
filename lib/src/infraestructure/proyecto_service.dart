import 'package:controlinventario/src/core/interfaces/response-proyecto.dart';
import 'package:controlinventario/src/domain/proyecto.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../core/util/constantes.dart';

class ProyectoService {
  Future<ResponseProyecto> getProyectos() async {
    final url = "${Envinronment.API_INVENTARIO}/proyecto/listar";
    final response = await http.get(Uri.parse(url));

    final decodedResp = json.decode(response.body);

    if (response.statusCode == 200) {
      return new ResponseProyecto.fromJsonMap(decodedResp);
    } else {
      return new ResponseProyecto.fromJsonMapError("Error al buscar");
    }
  }

  Future<ResponseProyecto> postProyecto(Map<String, dynamic> proyecto) async {
    try {
      final url = "${Envinronment.API_INVENTARIO}/proyecto/guardar";

      final request = {
        "nombre": proyecto["nombre"],
        "cliente": proyecto["cliente"],
        "fechaInicio": proyecto["fechaInicio"],
        "fechaFin": proyecto["fechaFin"],
        "articulo": proyecto["articulos"],
      };

      final response =
          await http.post(Uri.parse(url), body: jsonEncode(request));

      final decodedResp = json.decode(response.body);

      if (response.statusCode < 400) {
        return new ResponseProyecto.fromJsonMapSuccess(decodedResp["message"]);
      } else {
        return new ResponseProyecto.fromJsonMapError(decodedResp["message"]);
      }
    } catch (e) {
      return new ResponseProyecto.fromJsonMapError("Error");
    }
  }

  Future<ResponseProyecto> putProyecto(Map<String, dynamic> proyecto) async {
    try {
      final url = "${Envinronment.API_INVENTARIO}/proyecto/editar";

      final request = {
        "id": proyecto["id"],
        "nombre": proyecto["nombre"],
        "cliente": proyecto["cliente"],
        "fechaInicio": proyecto["fechaInicio"],
        "fechaFin": proyecto["fechaFin"],
        "articulo": proyecto["articulos"],
      };

      final response =
          await http.put(Uri.parse(url), body: jsonEncode(request));

      final decodedResp = json.decode(response.body);

      if (response.statusCode < 400) {
        return new ResponseProyecto.fromJsonMapSuccess(decodedResp["message"]);
      } else {
        return new ResponseProyecto.fromJsonMapError(decodedResp["message"]);
      }
    } catch (e) {
      return new ResponseProyecto.fromJsonMapError("Error");
    }
  }

  Future<ResponseProyecto> putVigenteProyecto(
      String idProyecto, Map<String, dynamic> proyecto) async {
    try {
      final url = "${Envinronment.API_INVENTARIO}/proyecto/vigente";

      final request = {
        "id": idProyecto.toString(),
        "articulo": proyecto["articulos"],
      };

      final response =
          await http.put(Uri.parse(url), body: jsonEncode(request));

      final decodedResp = json.decode(response.body);

      if (response.statusCode < 400) {
        return new ResponseProyecto.fromJsonMapSuccess(decodedResp["message"]);
      } else {
        return new ResponseProyecto.fromJsonMapError(decodedResp["message"]);
      }
    } catch (e) {
      return new ResponseProyecto.fromJsonMapError("Error");
    }
  }

  Future<ResponseProyecto> deleteProyecto(int idProyecto) async {
    try {
      final url =
          "${Envinronment.API_INVENTARIO}/proyecto/eliminar?IdProyecto=$idProyecto";
      final response = await http.delete(Uri.parse(url));

      final decodedResp = json.decode(response.body);

      if (response.statusCode < 400) {
        return new ResponseProyecto.fromJsonMap(decodedResp);
      } else {
        return new ResponseProyecto.fromJsonMapError("Error");
      }
    } catch (e) {
      return new ResponseProyecto.fromJsonMapError("Error");
    }
  }
}
