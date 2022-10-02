import 'package:controlinventario/src/UI/feature/almacen/almacen_page.dart';
import 'package:controlinventario/src/UI/feature/articulo/articulo_page.dart';
import 'package:controlinventario/src/UI/feature/proyecto/proyecto_page.dart';
import 'package:controlinventario/src/UI/feature/usuario/usuario_page.dart';
import 'package:controlinventario/src/UI/layout/admin/admin_page.dart';
import 'package:controlinventario/src/UI/layout/auth/auth_page.dart';
import 'package:flutter/material.dart';

import '../../UI/feature/inventario/inventario_page.dart';

class Routes {
  static String AUTH = '/';
  static String ADMIN = 'portal';

  static String ARTICULO = 'articulo';
  // static String ARTICULO_CREAR = 'articulo-crear';

  static String ALMACEN = 'almacen';
  // static String ALMACEN_CREAR = 'almacen-crear';

  static String PROYECTO = 'proyecto';
  // static String PROYECTO_CREAR = 'proyecto-crear';

  static String USUARIO = 'usuario';
  // static String USUARIO_CREAR = 'usuario-crear';

  static Map<String, WidgetBuilder> getRoutes() {
    return <String, WidgetBuilder>{
      Routes.AUTH: (context) => AuthPage(),
      Routes.ADMIN: (context) => AdminPage(),
      Routes.ARTICULO: (context) => InventarioPage(),
      Routes.ARTICULO: (context) => ArticuloPage(),
      Routes.ALMACEN: (context) => AlmacenPage(),
      Routes.PROYECTO: (context) => ProyectoPage(),
      Routes.USUARIO: (context) => UsuarioPage()
    };
  }
}
