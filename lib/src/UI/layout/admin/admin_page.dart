import 'package:controlinventario/src/UI/feature/inventario/inventario_page.dart';
import 'package:controlinventario/src/UI/feature/tablero/tablero_page.dart';
import 'package:controlinventario/src/UI/layout/admin/admin_provider.dart';
import 'package:controlinventario/src/UI/layout/auth/auth_provider.dart';
import 'package:controlinventario/src/core/util/constantes.dart';
import 'package:controlinventario/src/core/util/routes.dart';
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
        backgroundColor: Envinronment.colorBackground,
        body: _pageCurrent(adminProvider),
        floatingActionButton: _floatinButton(adminProvider),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: adminProvider.paginaActual,
          onTap: (index) {
            setState(() {
              adminProvider.setPaginaActual = index;
            });
          },
          backgroundColor: Envinronment.colorWhite,
          fixedColor: Envinronment.colorSecond,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.dashboard), label: 'Dashboard'),
            BottomNavigationBarItem(
                icon: Icon(Icons.inbox), label: 'Inventario'),
          ],
        ));
  }

  _pageCurrent(AdminProvider adminProvider) {
    if (adminProvider.paginaActual == 0) {
      return TableroPage();
    }
    if (adminProvider.paginaActual == 1) {
      return InventarioPage();
    }
    return TableroPage();
  }

  _floatinButton(AdminProvider adminProvider) {
    if (adminProvider.paginaActual == 0) {
      return null;
    } else {
      return FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.INVENTARIO_CREAR);
        },
        backgroundColor: Envinronment.colorSecond,
        child: const Icon(Icons.add),
      );
    }
  }
}
