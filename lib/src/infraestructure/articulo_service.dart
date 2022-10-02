import 'package:controlinventario/src/core/interfaces/response-articulo.dart';
import 'package:http/http.dart' as http;

class ArticuloService {
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
          "precio": 120.00,
          "almacen": null
        },
        {
          "id": 1,
          "url": "https",
          "nombre": "Sierra circular",
          "categoria": {
            "id": 1,
            "nombre": "Herramienta",
          },
          "precio": 120.00,
          "almacen": null
        },
        {
          "id": 1,
          "url": "https",
          "nombre": "Sierra circular",
          "categoria": {
            "id": 1,
            "nombre": "Herramienta",
          },
          "precio": 120.00,
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
}
