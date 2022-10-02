import 'package:controlinventario/src/core/interfaces/response-usuario.dart';
import 'package:http/http.dart' as http;

class UsuarioService {
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
          "rol": {"id": 2, "nombre": "Administrador"},
        },
        {
          "id": 1,
          "nombre": "Perez",
          "direccion": "Asoc. Horacio Zevallos",
          "usuario": "jchutas",
          "contrasenia": "",
          "rol": {"id": 2, "nombre": "Administrador"},
        },
        {
          "id": 1,
          "nombre": "Perez",
          "direccion": "Asoc. Horacio Zevallos",
          "usuario": "jchutas",
          "contrasenia": "",
          "rol": {"id": 2, "nombre": "Administrador"},
        },
      ]
    };

    if (response.statusCode == 200) {
      return new ResponseUsuario.fromJsonMap(decodedResp);
    } else {
      return new ResponseUsuario.fromJsonMapError("Error al buscar");
    }
  }
}
