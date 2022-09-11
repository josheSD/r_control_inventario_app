import 'package:controlinventario/src/UI/feature/tablero/tablero_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'tablero_provider.dart';

class TableroPage extends StatefulWidget {

  @override
  State<TableroPage> createState() => _TableroPageState();
}

class _TableroPageState extends State<TableroPage> {

  @override
  void initState() {
    // TODO: implement initState
    print('INIT Tablero');
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    print('DISPOSE Tablero');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tableroProvider = Provider.of<TableroProvider>(context, listen: false);
    return SafeArea(child: Container(child: Text('Tablero'),));
  }
}