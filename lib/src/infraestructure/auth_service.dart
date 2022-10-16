import 'package:controlinventario/src/core/interfaces/response-login.dart';
import 'package:controlinventario/src/core/shared-preferences/user.preference.dart';
import 'package:controlinventario/src/core/util/constantes.dart';
import 'package:controlinventario/src/domain/auth.dart';
import 'package:controlinventario/src/domain/login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  UserPreference _userPreference = new UserPreference();

  Future<ResponseLogin> login(Auth auth) async {
    try {
      final url = "${Envinronment.API_PERSONAL}/login/normal";

      final request = {"user": auth.usuario, "password": auth.contrasenia};

      final response =
          await http.post(Uri.parse(url), body: jsonEncode(request));

      // final decodedResp = {
      //   "status": true,
      //   "message": "éxito",
      //   "data": {
      //     "nombre": "rchutas",
      //     "direccion": "rchutas",
      //     "usuario": "rchutas@gmail.com",
      //     "rol": {"id": 1, "nombre": "Administrador"},
      //     "token": "eeerejri32jri3jiroj32ñoirjio23jr"
      //   }
      // };

      final decodedResp = json.decode(response.body);

      if (response.statusCode < 400) {
        return new ResponseLogin.fromJsonMap(decodedResp);
      } else {
        return new ResponseLogin.fromJsonMapError(decodedResp['message']);
      }
    } catch (e) {
      return new ResponseLogin.fromJsonMapError("Error al buscar");
    }
  }
}
