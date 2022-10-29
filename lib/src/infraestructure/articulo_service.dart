import 'dart:io';

import 'package:controlinventario/src/core/interfaces/response-articulo.dart';
import 'package:controlinventario/src/core/interfaces/response-categoria.dart';
import 'package:controlinventario/src/core/interfaces/response-imagen.dart';
import 'package:controlinventario/src/core/util/constantes.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart';

class ArticuloService {
  Future<ResponseImagen> postImagen(File file) async {
    try {
      final url = "${Envinronment.API_INVENTARIO}/articulo/imagen";

      http.MultipartRequest request =
          new http.MultipartRequest("POST", Uri.parse(url));

      http.MultipartFile multipartFile =
          await http.MultipartFile.fromPath('fileImagen', file.path);

      request.files.add(multipartFile);

      String nombre = basename(file.path);
      final fileNombre = "${Uuid().v1()}${Envinronment.URL_SPLIT_IMAGE}$nombre";
      
      request.fields["fileNombre"] = "$fileNombre";

      Uuid().v1().contains(fileNombre);

      http.StreamedResponse response = await request.send();

      if (response.statusCode < 400) {
        return new ResponseImagen.fromJsonMap(fileNombre);
      } else {
        return new ResponseImagen.fromJsonMapError("Error al guardar");
      }
    } catch (e) {
      return new ResponseImagen.fromJsonMapError("Error al guardar");
    }
  }

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

  Future<ResponseArticulo> postArticulo(Map<String, dynamic> articulo,String fileNombre) async {
    try {
      final url = "${Envinronment.API_INVENTARIO}/articulo/guardar";
      
      final request = {
        "nombre": articulo["nombre"],
        "url": fileNombre,
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

  Future<ResponseArticulo> putArticulo(Map<String, dynamic> articulo,String fileNombre) async {
    try {
      final url = "${Envinronment.API_INVENTARIO}/articulo/editar";

      final request = {
        "id": articulo["id"],
        "nombre": articulo["nombre"],
        "url": fileNombre,
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
