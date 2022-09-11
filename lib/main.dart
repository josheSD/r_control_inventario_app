import 'package:controlinventario/src/UI/feature/inventario-crear/inventario_crear_provider.dart';
import 'package:controlinventario/src/UI/feature/inventario/inventario_provider.dart';
import 'package:controlinventario/src/UI/feature/tablero/tablero_provider.dart';
import 'package:controlinventario/src/UI/layout/admin/admin_provider.dart';
import 'package:controlinventario/src/UI/layout/auth/auth_provider.dart';
import 'package:controlinventario/src/core/shared-preferences/user.preference.dart';
import 'package:controlinventario/src/core/util/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final userPreference = new UserPreference();
  await userPreference.initPreferencias();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    UserPreference userPreference = new UserPreference();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => AdminProvider()),
        ChangeNotifierProvider(create: (context) => TableroProvider()),
        ChangeNotifierProvider(create: (context) => InventarioProvider()),
        ChangeNotifierProvider(create: (context) => InventarioCrearProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Inventario App',
        initialRoute: (userPreference.token == '') ? Routes.AUTH : Routes.ADMIN,
        routes: Routes.getRoutes(),
      ),
    );
    
  }
}