import 'package:controlinventario/src/core/interfaces/response-proyecto.dart';
import 'package:controlinventario/src/core/interfaces/response-usuario.dart';
import 'package:controlinventario/src/infraestructure/usuario_service.dart';
import 'package:flutter/material.dart';

class UsuarioProvider with ChangeNotifier {
  UsuarioService _usuarioService = new UsuarioService();

  Future<ResponseUsuario> getUsuarios() async{

    ResponseUsuario response = await _usuarioService.getUsuarios();
    return response;

  }


}
