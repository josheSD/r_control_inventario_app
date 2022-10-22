import 'dart:convert';

import 'package:controlinventario/src/core/interfaces/response-usuario.dart';
import 'package:controlinventario/src/core/util/constantes.dart';
import 'package:controlinventario/src/domain/usuario.dart';
import 'package:http/http.dart' as http;

import '../core/interfaces/response-rol.dart';

class UsuarioService {
  Future<ResponseRol> getRoles() async {
    try {
      final url = "${Envinronment.API_PERSONAL}/rol/listar";
      final response = await http.get(Uri.parse(url));

      final decodedResp = json.decode(response.body);

      if (response.statusCode == 200) {
        return new ResponseRol.fromJsonMap(decodedResp);
      } else {
        return new ResponseRol.fromJsonMapError("Error al buscar");
      }
    } catch (e) {
      return new ResponseRol.fromJsonMapError("Error al buscar");
    }
  }

  Future<ResponseUsuario> getUsuarios() async {
    try {
      final url = "${Envinronment.API_PERSONAL}/usuario/listar";
      final response = await http.get(Uri.parse(url));

      final decodedResp = json.decode(response.body);

      if (response.statusCode == 200) {
        return new ResponseUsuario.fromJsonMap(decodedResp);
      } else {
        return new ResponseUsuario.fromJsonMapError("Error al buscar");
      }
    } catch (e) {
      return new ResponseUsuario.fromJsonMapError("Error al buscar");
    }
  }

  Future<ResponseUsuario> postUsuario(Map<String, dynamic> usuario) async {
    try {
      final url = "${Envinronment.API_PERSONAL}/usuario/guardar";

      final request = {
        "nombre": usuario["nombre"],
        "direccion": usuario["direccion"],
        "usuario": usuario["usuario"],
        "contrasenia": usuario["contrasenia"],
        "idRol": usuario["idRol"],
      };

      final response =
          await http.post(Uri.parse(url), body: jsonEncode(request));

      final decodedResp = json.decode(response.body);

      if (response.statusCode < 400) {
        return new ResponseUsuario.fromJsonMapSuccess(decodedResp["message"]);
      } else {
        return new ResponseUsuario.fromJsonMapError(decodedResp["message"]);
      }
    } catch (e) {
      return new ResponseUsuario.fromJsonMapError("Error");
    }
  }

  Future<ResponseUsuario> putUsuario(Map<String, dynamic> usuario) async {
    try {
      final url = "${Envinronment.API_PERSONAL}/usuario/editar";

      final request = {
        "id": usuario["id"],
        "nombre": usuario["nombre"],
        "direccion": usuario["direccion"],
        "usuario": usuario["usuario"],
        "contrasenia": usuario["contrasenia"],
        "idRol": usuario["idRol"],
      };

      final response =
          await http.put(Uri.parse(url), body: jsonEncode(request));

      final decodedResp = json.decode(response.body);

      if (response.statusCode < 400) {
        return new ResponseUsuario.fromJsonMapSuccess(decodedResp["message"]);
      } else {
        return new ResponseUsuario.fromJsonMapError(decodedResp["message"]);
      }
    } catch (e) {
      return new ResponseUsuario.fromJsonMapError("Error");
    }
  }

  Future<ResponseUsuario> deleteUsuario(int idUsuario) async {
    try {
      final url = "${Envinronment.API_PERSONAL}/usuario/eliminar?IdUsuario$idUsuario";
      final response = await http.delete(Uri.parse(url));

      final decodedResp = json.decode(response.body);

      if (response.statusCode < 400) {
        return new ResponseUsuario.fromJsonMapSuccess(decodedResp["message"]);
      } else {
        return new ResponseUsuario.fromJsonMapError(decodedResp["message"]);
      }
    } catch (e) {
      return new ResponseUsuario.fromJsonMapError("Error");
    }
  }
}
