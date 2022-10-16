import 'package:controlinventario/src/core/interfaces/response-almacen.dart';
import 'package:controlinventario/src/domain/almacen.dart';
import 'package:http/http.dart' as http;

class AlmacenService {
  Future<ResponseAlmacen> getAlmacenes() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/todos/1'));

    await Future.delayed(Duration(seconds: 1));

    final decodedResp = {
      "status": true,
      "message": "éxito",
      "data": [
        {
          "id": 1,
          "nombre": "Almacen 1",
          "direccion": "Asoc. Horacio Zevallos",
          "articulo": [
            {
              "id": 1,
              "url": "https",
              "nombre": "Sierra circular",
              "categoria": {
                "id": 1,
                "nombre": "Herramienta",
              },
              "precio": "120.00",
              "cantidad": 4
            },
            {
              "id": 1,
              "url": "https",
              "nombre": "Sierra circular",
              "categoria": {
                "id": 1,
                "nombre": "Herramienta",
              },
              "precio": "120.00",
              "cantidad": 4
            },
          ],
        },
        {
          "id": 2,
          "nombre": "Almacen 2",
          "direccion": "Asoc. Horacio Zevallos",
          "articulo": [
            {
              "id": 1,
              "url": "https",
              "nombre": "Sierra circular",
              "categoria": {
                "id": 1,
                "nombre": "Herramienta",
              },
              "precio": "120.00",
              "cantidad": 3
            },
            {
              "id": 2,
              "url": "https",
              "nombre": "Sierra circular",
              "categoria": {
                "id": 1,
                "nombre": "Herramienta",
              },
              "precio": "140.00",
              "cantidad": 2
            },
            {
              "id": 2,
              "url": "https",
              "nombre": "Sierra circular",
              "categoria": {
                "id": 1,
                "nombre": "Herramienta",
              },
              "precio": "140.00",
              "cantidad": 2
            },
          ],
        },
        {
          "id": 3,
          "nombre": "Almacen 3",
          "direccion": "Asoc. Horacio Zevallos",
          "articulo": [
            {
              "id": 1,
              "url": "https",
              "nombre": "Sierra circular",
              "categoria": {
                "id": 1,
                "nombre": "Herramienta",
              },
              "precio": "166.00",
              "cantidad": 1
            },
          ],
        },
      ]
    };

    if (response.statusCode == 200) {
      return new ResponseAlmacen.fromJsonMap(decodedResp);
    } else {
      return new ResponseAlmacen.fromJsonMapError("Error al buscar");
    }
  }

  
  Future<ResponseAlmacen> postAlmacen(Almacen almacen) async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/todos/1'));

    await Future.delayed(Duration(seconds: 1));

    final decodedResp = {"status": true, "message": "éxito", "data": []};

    if (response.statusCode == 200) {
      return new ResponseAlmacen.fromJsonMap(decodedResp);
    } else {
      return new ResponseAlmacen.fromJsonMapError("Error");
    }
  }

  Future<ResponseAlmacen> putAlmacen(Almacen almacen) async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/todos/1'));

    await Future.delayed(Duration(seconds: 1));

    final decodedResp = {"status": true, "message": "éxito", "data": []};

    if (response.statusCode == 200) {
      return new ResponseAlmacen.fromJsonMap(decodedResp);
    } else {
      return new ResponseAlmacen.fromJsonMapError("Error");
    }
  }

  Future<ResponseAlmacen> deleteAlmacen(int idAlmacen) async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/todos/1'));

    await Future.delayed(Duration(seconds: 1));

    final decodedResp = {"status": true, "message": "éxito", "data": []};

    if (response.statusCode == 200) {
      return new ResponseAlmacen.fromJsonMap(decodedResp);
    } else {
      return new ResponseAlmacen.fromJsonMapError("Error");
    }
  }
}
