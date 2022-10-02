import 'package:controlinventario/src/core/interfaces/response-proyecto.dart';
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
          "fechaInicio": "fechaInicio",
          "fechaFin": "fechaFin",
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
          "fechaInicio": "fechaInicio",
          "fechaFin": "fechaFin",
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
}
