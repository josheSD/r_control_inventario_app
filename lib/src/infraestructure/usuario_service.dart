import 'package:controlinventario/src/core/interfaces/response-usuario.dart';
import 'package:controlinventario/src/domain/usuario.dart';
import 'package:http/http.dart' as http;

import '../core/interfaces/response-rol.dart';

class UsuarioService {
  Future<ResponseRol> getRoles() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/todos/1'));

    await Future.delayed(Duration(seconds: 1));

    final decodedResp = {
      "status": true,
      "message": "éxito",
      "data": [
        {
          "id": 1,
          "nombre": "Administrador",
        },
        {"id": 2, "nombre": "Almacenedero"},
      ]
    };

    if (response.statusCode == 200) {
      return new ResponseRol.fromJsonMap(decodedResp);
    } else {
      return new ResponseRol.fromJsonMapError("Error al buscar");
    }
  }

  Future<ResponseUsuario> getUsuarios() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/todos/1'));

    await Future.delayed(Duration(seconds: 1));

    final decodedResp = {
      "status": true,
      "message": "éxito",
      "data": [
        {
          "id": 1,
          "nombre": "Perez",
          "direccion": "Asoc. Horacio Zevallos",
          "usuario": "jchutas",
          "contrasenia": "",
          "rol": {"id": 1, "nombre": "Administrador"},
        },
        {
          "id": 1,
          "nombre": "Perez",
          "direccion": "Asoc. Horacio Zevallos",
          "usuario": "jchutas",
          "contrasenia": "",
          "rol": {"id": 2, "nombre": "Almacenedero"},
        },
        {
          "id": 1,
          "nombre": "Perez",
          "direccion": "Asoc. Horacio Zevallos",
          "usuario": "jchutas",
          "contrasenia": "",
          "rol": {"id": 2, "nombre": "Almacenedero"},
        },
      ]
    };

    if (response.statusCode == 200) {
      return new ResponseUsuario.fromJsonMap(decodedResp);
    } else {
      return new ResponseUsuario.fromJsonMapError("Error al buscar");
    }
  }

  Future<ResponseUsuario> postUsuario(Usuario usuario) async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/todos/1'));

    await Future.delayed(Duration(seconds: 1));

    final decodedResp = {"status": true, "message": "éxito", "data": []};

    if (response.statusCode == 200) {
      return new ResponseUsuario.fromJsonMap(decodedResp);
    } else {
      return new ResponseUsuario.fromJsonMapError("Error");
    }
  }

  Future<ResponseUsuario> putUsuario(Usuario usuario) async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/todos/1'));

    await Future.delayed(Duration(seconds: 1));

    final decodedResp = {"status": true, "message": "éxito", "data": []};

    if (response.statusCode == 200) {
      return new ResponseUsuario.fromJsonMap(decodedResp);
    } else {
      return new ResponseUsuario.fromJsonMapError("Error");
    }
  }

  Future<ResponseUsuario> deleteUsuario(int idUsuario) async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/todos/1'));

    await Future.delayed(Duration(seconds: 1));

    final decodedResp = {"status": true, "message": "éxito", "data": []};

    if (response.statusCode == 200) {
      return new ResponseUsuario.fromJsonMap(decodedResp);
    } else {
      return new ResponseUsuario.fromJsonMapError("Error");
    }
  }
}
