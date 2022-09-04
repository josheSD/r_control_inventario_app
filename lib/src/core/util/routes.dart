import 'package:controlinventario/src/UI/layout/admin/admin_page.dart';
import 'package:controlinventario/src/UI/layout/auth/auth_page.dart';
import 'package:flutter/material.dart';

class Routes {
  static String AUTH = '/';
  static String ADMIN = 'portal';

  static Map<String, WidgetBuilder> getRoutes() {
    return <String, WidgetBuilder>{
      Routes.AUTH: (context) => AuthPage(),
      Routes.ADMIN: (context) => AdminPage(),
    };
  }
}
