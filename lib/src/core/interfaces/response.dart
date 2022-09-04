
class Response<T>{
  late bool status;
  late String message;
  late T data;

  Response.fromJsonMap(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'];
    message = json['message'];
  }

  Response.fromJsonMapError(String message) {
    status = false;
    message = message;
  }

}