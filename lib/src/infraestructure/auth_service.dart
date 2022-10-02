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
      String url = '${Envinronment.urlPersonal}/login';

      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };

      final form = {'email': auth.usuario, 'password': auth.contrasenia};

      http.Response resp = await http.post(Uri.parse(url),
          body: jsonEncode(form), headers: headers);

      final decodedResp = json.decode(resp.body);

      if (resp.statusCode == 200) {
        final response = new ResponseLogin.fromJsonMap(decodedResp);

        // _userPreference.setUsername = response.message;

        return response;
      } else {
        return new ResponseLogin.fromJsonMap(decodedResp);
      }
    } catch (e) {
      return new ResponseLogin.fromJsonMapError(e.toString());
    }
  }
}
