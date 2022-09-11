import 'package:controlinventario/src/core/interfaces/response-inventario.dart';
import 'package:controlinventario/src/core/interfaces/response-tipo-inventario.dart';
import 'package:http/http.dart' as http;

class InventarioService {

  Future<ResponseInventario> getInventarios() async {
    final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/todos/1'));

    final decodedResp = {
        "status": true,
        "message": "éxito",
        "data": [
            {
                "id": 1,
                "nombre": "Material 1",
                "costo": 1500.00
            },
            {
                "id": 2,
                "nombre": "Material 2",
                "costo": 1500.00
            },
            {
                "id": 3,
                "nombre": "Material 3",
                "costo": 1500.00
            },
            {
                "id": 4,
                "nombre": "Material 4",
                "costo": 1500.00
            },
            {
                "id": 5,
                "nombre": "Material 5",
                "costo": 1500.00
            },
            {
                "id": 6,
                "nombre": "Material 6",
                "costo": 1500.00
            },
            {
                "id": 7,
                "nombre": "Material 7",
                "costo": 1500.00
            },
            {
                "id": 8,
                "nombre": "Material 8",
                "costo": 1500.00
            },
            {
                "id": 9,
                "nombre": "Material 9",
                "costo": 1500.00
            },
            {
                "id": 10,
                "nombre": "Material 10",
                "costo": 1500.00
            },
        ]
    };

    if (response.statusCode == 200) {
      return new ResponseInventario.fromJsonMap(decodedResp);
    }else{
      return new ResponseInventario.fromJsonMapError("Error al buscar");
    }

  }

  Future<ResponseTipoInventario> getTipoInventario() async{
    final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/todos/1'));

        final decodedResp = {
        "status": true,
        "message": "éxito",
        "data": [
            {
                "id": 1,
                "nombre": "Tipo 1",
            },
            {
                "id": 2,
                "nombre": "Tipo 2",
            },
            {
                "id": 3,
                "nombre": "Tipo 3",
            },
            {
                "id": 4,
                "nombre": "Tipo 4",
            },
            {
                "id": 5,
                "nombre": "Tipo 5",
            },
            {
                "id": 6,
                "nombre": "Tipo 6",
            },
        ]
    };

    if (response.statusCode == 200) {
      return new ResponseTipoInventario.fromJsonMap(decodedResp);
    }else{
      return new ResponseTipoInventario.fromJsonMapError("Error al buscar");
    }

  }
}
