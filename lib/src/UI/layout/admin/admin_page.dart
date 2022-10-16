import 'package:controlinventario/src/UI/feature/tablero/tablero_page.dart';
import 'package:controlinventario/src/UI/layout/admin/admin_provider.dart';
import 'package:controlinventario/src/core/util/constantes.dart';
import 'package:controlinventario/src/core/util/routes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../core/shared-preferences/user.preference.dart';

class AdminPage extends StatefulWidget {
  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {

  late AdminProvider adminProvider;

  @override
  Widget build(BuildContext context) {
    adminProvider = Provider.of<AdminProvider>(context, listen: false);
    final userPreference = new UserPreference();

    return Scaffold(
      backgroundColor: Envinronment.colorBackground,
      body: TableroPage(),
      appBar: AppBar(
        backgroundColor: Envinronment.colorBackground,
        titleTextStyle: TextStyle(color: Envinronment.colorBlack),
        elevation: 0,
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.menu),
            color: Envinronment.colorPrimary,
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        }),
      ),
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            padding: EdgeInsets.all(0),
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(FontAwesomeIcons.circleUser,size: 60),
                SizedBox(height: 15,),
                Text(userPreference.nombre,
                    style: TextStyle(fontWeight: FontWeight.normal)),
                SizedBox(height: 10,),
                Text(userPreference.rol,
                    style: TextStyle(fontWeight: FontWeight.normal)),
              ],
            ),
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.wrench),
            title: const Text('Artículo',
                style: TextStyle(fontWeight: FontWeight.normal)),
            onTap: () {
              Navigator.pushNamed(context, Routes.ARTICULO);
            },
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.tent),
            title: const Text('Almacén',
                style: TextStyle(fontWeight: FontWeight.normal)),
            onTap: () {
              Navigator.pushNamed(context, Routes.ALMACEN);
            },
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.solidBuilding),
            title: const Text('Proyecto',
                style: TextStyle(fontWeight: FontWeight.normal)),
            onTap: () {
              Navigator.pushNamed(context, Routes.PROYECTO);
            },
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.userLarge),
            title: const Text('Usuario',
                style: TextStyle(fontWeight: FontWeight.normal)),
            onTap: () {
              Navigator.pushNamed(context, Routes.USUARIO);
            },
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.circleChevronLeft),
            title: const Text('Salir',
                style: TextStyle(fontWeight: FontWeight.normal)),
            onTap: () {
              adminProvider.signOut();
              Navigator.pushNamed(context, Routes.AUTH);
            },
          ),
        ],
      )),
    );
  }
}
