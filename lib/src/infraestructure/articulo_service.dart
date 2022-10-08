import 'package:controlinventario/src/core/interfaces/response-articulo.dart';
import 'package:controlinventario/src/core/interfaces/response-categoria.dart';
import 'package:controlinventario/src/domain/articulo.dart';
import 'package:http/http.dart' as http;

class ArticuloService {

  Future<ResponseCategoria> getCategorias() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/todos/1'));

    final decodedResp = {
      "status": true,
      "message": "éxito",
      "data": [
        {
          "id": 1,
          "nombre": "Herramienta",
        },
        {
          "id": 2,
          "nombre": "Material",
        },
      ]
    };

    if (response.statusCode == 200) {
      return new ResponseCategoria.fromJsonMap(decodedResp);
    } else {
      return new ResponseCategoria.fromJsonMapError("Error al buscar");
    }
  }

  Future<ResponseArticulo> getArticulos() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/todos/1'));

    await Future.delayed(Duration(seconds: 1));

    final decodedResp = {
      "status": true,
      "message": "éxito",
      "data": [
        {
          "id": 1,
          "url": "https",
          "nombre": "Sierra circular",
          "categoria": {
            "id": 1,
            "nombre": "Herramienta",
          },
          "precio": 130.00,
          "almacen": null
        },
        {
          "id": 2,
          "url": "https",
          "nombre": "Moto Sierra",
          "categoria": {
            "id": 1,
            "nombre": "Herramienta",
          },
          "precio": 140.00,
          "almacen": null
        },
        {
          "id": 3,
          "url": "https",
          "nombre": "Ventilador",
          "categoria": {
            "id": 2,
            "nombre": "Material",
          },
          "precio": 150.00,
          "almacen": null
        },
      ]
    };

    if (response.statusCode == 200) {
      return new ResponseArticulo.fromJsonMap(decodedResp);
    } else {
      return new ResponseArticulo.fromJsonMapError("Error al buscar");
    }
  }

  Future<ResponseArticulo> postArticulo(Articulo articulo) async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/todos/1'));

    await Future.delayed(Duration(seconds: 1));

    final decodedResp = {"status": true, "message": "éxito", "data": []};

    if (response.statusCode == 200) {
      return new ResponseArticulo.fromJsonMap(decodedResp);
    } else {
      return new ResponseArticulo.fromJsonMapError("Error");
    }
  }

  Future<ResponseArticulo> putArticulo(Articulo articulo) async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/todos/1'));

    await Future.delayed(Duration(seconds: 1));

    final decodedResp = {"status": true, "message": "éxito", "data": []};

    if (response.statusCode == 200) {
      return new ResponseArticulo.fromJsonMap(decodedResp);
    } else {
      return new ResponseArticulo.fromJsonMapError("Error");
    }
  }

  Future<ResponseArticulo> deleteArticulo(int idArticulo) async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/todos/1'));

    await Future.delayed(Duration(seconds: 1));

    final decodedResp = {"status": true, "message": "éxito", "data": []};

    if (response.statusCode == 200) {
      return new ResponseArticulo.fromJsonMap(decodedResp);
    } else {
      return new ResponseArticulo.fromJsonMapError("Error");
    }
  }
}
