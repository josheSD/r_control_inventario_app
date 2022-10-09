import 'package:controlinventario/src/core/interfaces/response-proyecto.dart';
import 'package:controlinventario/src/domain/proyecto.dart';
import 'package:http/http.dart' as http;

class ProyectoService {
  Future<ResponseProyecto> getProyectos() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/todos/1'));

    await Future.delayed(Duration(seconds: 1));

    final decodedResp = {
      "status": true,
      "message": "éxito",
      "data": [
        {
          "id": 1,
          "nombre": "Las lomas",
          "cliente": "Municipalidad de Lima",
          "fechaInicio": "2022-10-11T00:00:00.000",
          "fechaFin": "2022-10-11T00:00:00.000",
          "contrato": "contrato",
          "articulo": [
            {
              "id": 1,
              "url": "url",
              "nombre": "nombre",
              "categoria": {
                "id": 1,
                "nombre": "categoria",
              },
              "precio": 100.00,
              "cantidad": 4,
              "almacen": {
                "id": 1,
                "nombre": "Almacen",
                "direccion": "direccion",
                "articulo": [],
              }
            }
          ],
          "estado": 0
        },
        {
          "id": 1,
          "nombre": "Las lomas",
          "cliente": "Municipalidad de Lima",
          "fechaInicio": "2022-10-11T00:00:00.000",
          "fechaFin": "2022-10-11T00:00:00.000",
          "contrato": "contrato",
          "articulo": [
            {
              "id": 1,
              "url": "url",
              "nombre": "nombre",
              "categoria": {
                "id": 1,
                "nombre": "categoria",
              },
              "precio": 100.00,
              "cantidad": 5,
              "almacen": {
                "id": 1,
                "nombre": "Almacen",
                "direccion": "direccion",
                "articulo": [],
              }
            }
          ],
          "estado": 1
        },
      ]
    };

    if (response.statusCode == 200) {
      return new ResponseProyecto.fromJsonMap(decodedResp);
    } else {
      return new ResponseProyecto.fromJsonMapError("Error al buscar");
    }
  }

  
  
  Future<ResponseProyecto> postProyecto(Proyecto proyecto) async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/todos/1'));

    await Future.delayed(Duration(seconds: 1));

    final decodedResp = {"status": true, "message": "éxito", "data": []};

    if (response.statusCode == 200) {
      return new ResponseProyecto.fromJsonMap(decodedResp);
    } else {
      return new ResponseProyecto.fromJsonMapError("Error");
    }
  }

  Future<ResponseProyecto> putProyecto(Proyecto proyecto) async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/todos/1'));

    await Future.delayed(Duration(seconds: 1));

    final decodedResp = {"status": true, "message": "éxito", "data": []};

    if (response.statusCode == 200) {
      return new ResponseProyecto.fromJsonMap(decodedResp);
    } else {
      return new ResponseProyecto.fromJsonMapError("Error");
    }
  }

  Future<ResponseProyecto> deleteProyecto(int idAlmacen) async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/todos/1'));

    await Future.delayed(Duration(seconds: 1));

    final decodedResp = {"status": true, "message": "éxito", "data": []};

    if (response.statusCode == 200) {
      return new ResponseProyecto.fromJsonMap(decodedResp);
    } else {
      return new ResponseProyecto.fromJsonMapError("Error");
    }
  }

}
