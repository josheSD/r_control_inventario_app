import 'package:controlinventario/src/UI/feature/dashboard/dashboard_page.dart';
import 'package:controlinventario/src/UI/feature/inventario/inventario_page.dart';
import 'package:controlinventario/src/UI/layout/admin/admin_provider.dart';
import 'package:controlinventario/src/UI/layout/auth/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminPage extends StatefulWidget {
  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    final adminProvider = Provider.of<AdminProvider>(context, listen: false);
    
    return Scaffold(
        body: _pageCurrent(adminProvider),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: adminProvider.paginaActual,
          onTap: (index){
            setState(() {
              adminProvider.setPaginaActual = index;
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
            BottomNavigationBarItem(icon: Icon(Icons.inbox), label: 'Inventario'),
          ],
        ));
  }
  
  Widget _pageCurrent(AdminProvider adminProvider) {
    if(adminProvider.paginaActual == 0){
      return DashboardPage();
    }
    if(adminProvider.paginaActual == 1){
      return InventarioPage();
    }
    return DashboardPage();
  }
}
