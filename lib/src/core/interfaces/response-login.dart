
import 'package:controlinventario/src/domain/login.dart';

class ResponseLogin{
  late bool status;
  late String message;
  late Login data;

  ResponseLogin.fromJsonMap(Map<String, dynamic> json) {
    status = json['status'];
    data = Login.fromJson(json["data"]);
    message = json['message'];
  }

  ResponseLogin.fromJsonMapError(String message) {
    status = false;
    message = message;
  }

}