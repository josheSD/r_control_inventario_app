import 'package:controlinventario/src/UI/feature/inventario-crear/inventario_crear_page.dart';
import 'package:controlinventario/src/UI/layout/admin/admin_page.dart';
import 'package:controlinventario/src/UI/layout/auth/auth_page.dart';
import 'package:flutter/material.dart';

class Routes {
  static String AUTH = '/';
  static String ADMIN = 'portal';
  static String INVENTARIO_CREAR = 'inventario-crear';

  static Map<String, WidgetBuilder> getRoutes() {
    return <String, WidgetBuilder>{
      Routes.AUTH: (context) => AuthPage(),
      Routes.ADMIN: (context) => AdminPage(),
      Routes.INVENTARIO_CREAR: (context) => InventarioCrearPage()
    };
  }
}
