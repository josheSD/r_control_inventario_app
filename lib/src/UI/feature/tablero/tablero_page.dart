import 'package:controlinventario/src/UI/feature/tablero/tablero_provider.dart';
import 'package:controlinventario/src/core/components/bar-chart.dart';
import 'package:controlinventario/src/core/components/pie-chart.dart';
import 'package:controlinventario/src/core/util/constantes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'tablero_provider.dart';

class TableroPage extends StatefulWidget {
  @override
  State<TableroPage> createState() => _TableroPageState();
}

class _TableroPageState extends State<TableroPage> {
  @override
  Widget build(BuildContext context) {
    final tableroProvider =
        Provider.of<TableroProvider>(context, listen: false);
    return Container(
        child: SingleChildScrollView(
            child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
            child: Container(
              margin: EdgeInsets.only(top: 20,bottom: 20),
              child: Text('Bienvenido',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28)),
            )),
        Center(
            child: Text('al sistema de control de inventario',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)))
      ],
    )));
  }

  _buildPie(BuildContext context, TableroProvider tableroProvider) {
    return Container(
      margin: EdgeInsets.only(left: 18, right: 18, bottom: 5),
      color: Envinronment.colorWhite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              margin: EdgeInsets.only(top: 20, bottom: 5),
              child: Text('Bar Chart')),
          Padding(
              padding: EdgeInsets.all(16),
              child: AspectRatio(aspectRatio: 16 / 9, child: BarChart())),
        ],
      ),
    );
  }

  _buildBar(BuildContext context, TableroProvider tableroProvider) {
    return Container(
      margin: EdgeInsets.only(left: 18, right: 18, bottom: 5),
      color: Envinronment.colorWhite,
      child: Column(
        children: [
          Container(
              margin: EdgeInsets.only(top: 20, bottom: 5),
              child: Text('Pie Chart')),
          Padding(
              padding: EdgeInsets.all(16),
              child: AspectRatio(aspectRatio: 16 / 9, child: PieChart())),
        ],
      ),
    );
  }
}
