import 'package:controlinventario/src/core/interfaces/response.dart';
import 'package:controlinventario/src/core/shared-preferences/user.preference.dart';
import 'package:controlinventario/src/core/util/constantes.dart';
import 'package:controlinventario/src/domain/auth.dart';
import 'package:controlinventario/src/domain/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  UserPreference _userPreference = new UserPreference();

  Future<Response<Usuario>> login(Auth auth) async {
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
        final response = new Response<Usuario>.fromJsonMap(decodedResp);

        // _userPreference.setUsername = response.message;

        return response;
      } else {
        return new Response<Usuario>.fromJsonMap(decodedResp);
      }
    } catch (e) {
      return new Response<Usuario>.fromJsonMapError(e.toString());
    }
  }
}
