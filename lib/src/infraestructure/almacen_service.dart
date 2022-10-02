import 'package:controlinventario/src/core/interfaces/response-almacen.dart';
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
              "precio": 120.00,
            }
          ],
          "precio": 120.00,
        },
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
              "precio": 120.00,
            }
          ],
          "precio": 120.00,
        },
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
              "precio": 120.00,
            }
          ],
          "precio": 120.00,
        },
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
              "precio": 120.00,
            }
          ],
          "precio": 120.00,
        },
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
              "precio": 120.00,
            }
          ],
          "precio": 120.00,
        },
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
              "precio": 120.00,
            }
          ],
          "precio": 120.00,
        },
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
              "precio": 120.00,
            }
          ],
          "precio": 120.00,
        },
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
              "precio": 120.00,
            }
          ],
          "precio": 120.00,
        },
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
              "precio": 120.00,
            }
          ],
          "precio": 120.00,
        },
      ]
    };

    if (response.statusCode == 200) {
      return new ResponseAlmacen.fromJsonMap(decodedResp);
    } else {
      return new ResponseAlmacen.fromJsonMapError("Error al buscar");
    }
  }
}
