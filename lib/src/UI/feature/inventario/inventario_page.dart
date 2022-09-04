import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'inventario_provider.dart';

class InventarioPage extends StatefulWidget {
  @override
  State<InventarioPage> createState() => _InventarioPageState();
}

class _InventarioPageState extends State<InventarioPage> {

  @override
  void initState() {
    // TODO: implement initState
    print('INIT INVENTARIO');
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    print('DISPOSE INVENTARIO');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final inventarioProvider = Provider.of<InventarioProvider>(context, listen: false);
    return SafeArea(
        child: Container(
      child: Text('Inventario'),
    ));
  }
}
