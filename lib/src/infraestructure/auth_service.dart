import 'package:controlinventario/src/core/util/constantes.dart';
import 'package:controlinventario/src/domain/auth.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future<bool> Login(Auth auth) async {
    final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/todos/1'));
    if (response.statusCode == 200) {
      return true;
    }
    ;
    return false;
  }
}
