import 'package:controlinventario/src/UI/feature/tablero/tablero_provider.dart';
import 'package:controlinventario/src/core/components/bar-chart-precision.dart';
import 'package:controlinventario/src/core/components/pie-chart.dart';
import 'package:controlinventario/src/core/util/constantes.dart';
import 'package:controlinventario/src/domain/precision.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../core/components/bar-chart-rotacion.dart';
import '../../../core/interfaces/response-precision.dart';
import '../../../core/interfaces/response-rotacion.dart';
import '../../../domain/rotacion.dart';
import '../../layout/admin/admin_page.dart';
import 'tablero_provider.dart';

class TableroPage extends StatefulWidget {
  @override
  State<TableroPage> createState() => _TableroPageState();
}

class _TableroPageState extends State<TableroPage> {
  late TableroProvider tableroProvider;
  bool _refreshRollback = false;

  @override
  Widget build(BuildContext context) {
    tableroProvider = Provider.of<TableroProvider>(context, listen: false);
    return Container(
        child: SingleChildScrollView(
            child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
            child: Container(
          margin: EdgeInsets.only(top: 0, bottom: 6),
          child: Text('Bienvenido',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
        )),
        Center(
            child: Text('al sistema de control de inventario',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
        SizedBox(
          height: 10,
        ),
        _buildBody(context)
      ],
    )));
  }

  _buildBody(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    return Column(
      children: [
        Container(
            height: queryData.size.height * 0.4,
            width: queryData.size.width,
            child: FutureBuilder(
                future: tableroProvider.getPrecisiones(),
                builder: (BuildContext context,
                    AsyncSnapshot<ResponsePrecision> snapshot) {
                  if (snapshot.hasData) {
                    List<Precision> precisiones = snapshot.data!.data;
                    return _buildListaPrecision(precisiones);
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                })),
        SizedBox(
          height: 5,
        ),
        Container(
            height: queryData.size.height * 0.4,
            width: queryData.size.width,
            child: FutureBuilder(
                future: tableroProvider.getRotaciones(),
                builder: (BuildContext context,
                    AsyncSnapshot<ResponseRotacion> snapshot) {
                  if (snapshot.hasData) {
                    List<Rotacion> rotaciones = snapshot.data!.data;
                    return _buildListaRotacion(rotaciones);
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                })),
      ],
    );
  }

  Widget _buildListaRotacion(List<Rotacion> rotaciones) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: rotaciones.length,
      itemBuilder: (context, i) => _itemRotacion(context, rotaciones[i]),
    );
  }

  Widget _itemRotacion(BuildContext context, Rotacion rotacion) {
    return Container(
      height: 200,
      width: 380,
      margin: EdgeInsets.only(left: 15, right: 15, bottom: 5),
      color: Envinronment.colorWhite,
      child: Padding(
          padding: EdgeInsets.all(16),
          child: AspectRatio(
              aspectRatio: 16 / 9,
              child: BarChartRotacion(rotacion: rotacion))),
    );
  }

  Widget _buildListaPrecision(List<Precision> precisiones) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: precisiones.length,
      itemBuilder: (context, i) => _itemPrecision(context, precisiones[i]),
    );
  }

  Widget _itemPrecision(BuildContext context, Precision precision) {
    return Container(
      height: 200,
      width: 380,
      margin: EdgeInsets.only(left: 15, right: 15, bottom: 5),
      color: Envinronment.colorWhite,
      child: Padding(
          padding: EdgeInsets.all(16),
          child: AspectRatio(
              aspectRatio: 16 / 9,
              child: BarChartPrecision(precision: precision))),
    );
  }

  Widget _buildListaError(ResponsePrecision response) {
    SnackBar snackBar = SnackBar(
        content: Text(response.message,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
        duration: Duration(seconds: 3),
        backgroundColor: Envinronment.colorDanger);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        snackBar,
      );
    });

    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  child: Text('No hay datos registrados',
                      style: TextStyle(color: Envinronment.colorBlack))),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Envinronment.colorButton,
                    shape: StadiumBorder(),
                    elevation: 0,
                  ),
                  onPressed: () async {
                    _handleRefresh();
                  },
                  child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Icon(
                        FontAwesomeIcons.arrowsRotate,
                        color: Envinronment.colorBlack,
                      )))
            ],
          ),
        ],
      ),
    );
  }

  Future<Null> _handleRefresh() async {
    Navigator.pushReplacement(
        context,
        PageRouteBuilder(
            pageBuilder: (a, b, c) => AdminPage(),
            transitionDuration: Duration(seconds: 0)));
  }
}
