import 'package:controlinventario/src/UI/feature/almacen-crear/almacen_crear_page.dart';
import 'package:controlinventario/src/UI/feature/almacen/almacen_page.dart';
import 'package:controlinventario/src/UI/feature/articulo-crear/articulo_crear_page.dart';
import 'package:controlinventario/src/UI/feature/articulo/articulo_page.dart';
import 'package:controlinventario/src/UI/feature/proyecto-crear/proyecto_crear_page.dart';
import 'package:controlinventario/src/UI/feature/proyecto/proyecto_page.dart';
import 'package:controlinventario/src/UI/feature/usuario-crear/usuario_crear_page.dart';
import 'package:controlinventario/src/UI/feature/usuario/usuario_page.dart';
import 'package:controlinventario/src/UI/layout/admin/admin_page.dart';
import 'package:controlinventario/src/UI/layout/auth/auth_page.dart';
import 'package:flutter/material.dart';

class Routes {
  static String AUTH = '/';
  static String ADMIN = 'portal';

  static String ARTICULO = 'articulo';
  static String ARTICULO_CREAR = 'articulo-crear';

  static String ALMACEN = 'almacen';
  static String ALMACEN_CREAR = 'almacen-crear';

  static String PROYECTO = 'proyecto';
  static String PROYECTO_CREAR = 'proyecto-crear';

  static String USUARIO = 'usuario';
  static String USUARIO_CREAR = 'usuario-crear';

  static Map<String, WidgetBuilder> getRoutes() {
    return <String, WidgetBuilder>{
      Routes.AUTH: (context) => AuthPage(),
      Routes.ADMIN: (context) => AdminPage(),
      Routes.ARTICULO: (context) => ArticuloPage(),
      Routes.ARTICULO_CREAR: (context) => ArticuloCrearPage(), 
      Routes.ALMACEN: (context) => AlmacenPage(),
      Routes.ALMACEN_CREAR: (context) => AlmacenCrearPage(),
      Routes.PROYECTO: (context) => ProyectoPage(),
      Routes.PROYECTO_CREAR: (context) => ProyectoCrearPage(),
      Routes.USUARIO: (context) => UsuarioPage(),
      Routes.USUARIO_CREAR: (context) => UsuarioCrearPage(),
    };
  }
}
