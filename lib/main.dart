import 'package:controlinventario/src/UI/feature/dashboard/dashboard_provider.dart';
import 'package:controlinventario/src/UI/feature/inventario/inventario_provider.dart';
import 'package:controlinventario/src/UI/layout/admin/admin_page.dart';
import 'package:controlinventario/src/UI/layout/admin/admin_provider.dart';
import 'package:controlinventario/src/UI/layout/auth/auth_page.dart';
import 'package:controlinventario/src/UI/layout/auth/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => AdminProvider()),
        ChangeNotifierProvider(create: (context) => DashboardProvider()),
        ChangeNotifierProvider(create: (context) => InventarioProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: '/',
        routes: {
          '/' : (context) => AuthPage(),
          'portal' : (context) => AdminPage(),
        }
      ),
    );
    
  }
}