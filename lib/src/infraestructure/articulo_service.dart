import 'package:controlinventario/src/core/interfaces/response-articulo.dart';
import 'package:controlinventario/src/core/interfaces/response-categoria.dart';
import 'package:controlinventario/src/core/util/constantes.dart';
import 'package:controlinventario/src/domain/articulo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ArticuloService {
  Future<ResponseArticulo> getArticulos() async {
    try {
      final url = "${Envinronment.API_INVENTARIO}/articulo/listar";
      final response = await http.get(Uri.parse(url));

      final decodedResp = json.decode(response.body);

      if (response.statusCode < 400) {
        return new ResponseArticulo.fromJsonMap(decodedResp);
      } else {
        return new ResponseArticulo.fromJsonMapError("Error al buscar");
      }
    } catch (e) {
      return new ResponseArticulo.fromJsonMapError("Error al buscar");
    }
  }

  Future<ResponseArticulo> postArticulo(Map<String, dynamic> articulo) async {
    try {
      final url = "${Envinronment.API_INVENTARIO}/articulo/guardar";

      final request = {
        "nombre": articulo["nombre"],
        "url": "https",
        "precio": articulo["precio"],
        "idCategoria": articulo["idCategoria"],
      };

      final response =
          await http.post(Uri.parse(url), body: jsonEncode(request));

      final decodedResp = json.decode(response.body);

      if (response.statusCode < 400) {
        return new ResponseArticulo.fromJsonMapSuccess(decodedResp["message"]);
      } else {
        return new ResponseArticulo.fromJsonMapError(decodedResp["message"]);
      }
    } catch (e) {
      return new ResponseArticulo.fromJsonMapError("Error");
    }
  }

  Future<ResponseArticulo> putArticulo(Map<String, dynamic> articulo) async {
    try {
      final url = "${Envinronment.API_INVENTARIO}/articulo/editar";

      final request = {
        "id": articulo["id"],
        "nombre": articulo["nombre"],
        "url": "https",
        "precio": articulo["precio"],
        "idCategoria": articulo["idCategoria"],
      };

      final response =
          await http.put(Uri.parse(url), body: jsonEncode(request));

      final decodedResp = json.decode(response.body);

      if (response.statusCode < 400) {
        return new ResponseArticulo.fromJsonMapSuccess(decodedResp["message"]);
      } else {
        return new ResponseArticulo.fromJsonMapError(decodedResp["message"]);
      }
    } catch (e) {
      return new ResponseArticulo.fromJsonMapError("Error");
    }
  }

  Future<ResponseArticulo> deleteArticulo(int idArticulo) async {
    try {
      final url =
          "${Envinronment.API_INVENTARIO}/articulo/eliminar?IdArticulo=$idArticulo";
      final response = await http.delete(Uri.parse(url));

      final decodedResp = json.decode(response.body);

      if (response.statusCode < 400) {
        return new ResponseArticulo.fromJsonMap(decodedResp);
      } else {
        return new ResponseArticulo.fromJsonMapError("Error al buscar");
      }
    } catch (e) {
      return new ResponseArticulo.fromJsonMapError("Error al eliminar");
    }
  }

  Future<ResponseCategoria> getCategorias() async {
    try {
      final url = "${Envinronment.API_INVENTARIO}/categoria/listar";
      final response = await http.get(Uri.parse(url));

      final decodedResp = json.decode(response.body);

      if (response.statusCode < 400) {
        return new ResponseCategoria.fromJsonMap(decodedResp);
      } else {
        return new ResponseCategoria.fromJsonMapError("Error al buscar");
      }
    } catch (e) {
      return new ResponseCategoria.fromJsonMapError("Error al buscar");
    }
  }
}
