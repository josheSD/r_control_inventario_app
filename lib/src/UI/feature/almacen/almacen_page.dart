import 'dart:io';

import 'package:controlinventario/src/UI/feature/almacen/almacen_provider.dart';
import 'package:controlinventario/src/core/interfaces/response-almacen.dart';
import 'package:controlinventario/src/core/util/constantes.dart';
import 'package:controlinventario/src/core/util/routes.dart';
import 'package:controlinventario/src/domain/almacen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../../core/util/directory.dart';
import '../../../core/util/report.dart';

class AlmacenPage extends StatefulWidget {
  @override
  State<AlmacenPage> createState() => _AlmacenPageState();
}

class _AlmacenPageState extends State<AlmacenPage> {
  bool _refreshRollback = false;
  bool _reporteLoading = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late AlmacenProvider almacenProvider;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    almacenProvider =
        Provider.of<AlmacenProvider>(context, listen: false);

    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Envinronment.colorBackground,
        appBar: AppBar(
          title: Text('Almacén',
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18)),
          centerTitle: true,
          backgroundColor: Envinronment.colorBackground,
          titleTextStyle: TextStyle(color: Envinronment.colorBlack),
          elevation: 0,
          leading: Builder(builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(FontAwesomeIcons.chevronLeft),
              color: Envinronment.colorPrimary,
              onPressed: () {
                Navigator.pop(context);
              },
            );
          }),
        ),
        body: Container(
            child: SingleChildScrollView(
                child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildReporte(context),
            _buildBody(context)
          ],
        ))),
        floatingActionButton: FloatingActionButton(
          elevation: 2,
          backgroundColor: Envinronment.colorButton,
          child: Icon(FontAwesomeIcons.plus,
              color: Envinronment.colorBlack, size: 24),
          onPressed: () {
            Navigator.pushNamed(context, Routes.ALMACEN_CREAR);
          },
        ));
  }

  _buildReporte(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 18, right: 18, bottom: 5),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 25),
          backgroundColor: Envinronment.colorButton,
          shape: StadiumBorder(),
          elevation: 0,
        ),
        child: Container(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(FontAwesomeIcons.solidFilePdf,
                  color: Envinronment.colorBlack),
              Container(
                padding: EdgeInsets.only(left: 5),
                child: Text('Reporte',
                    style: TextStyle(
                        color: Envinronment.colorBlack,
                        fontWeight: FontWeight.normal)),
              ),
              _reporteLoading
                  ? Container(
                      margin: EdgeInsets.only(left: 12),
                      child: SizedBox(
                        child: CircularProgressIndicator(
                            color: Envinronment.colorWhite),
                        height: 16.0,
                        width: 16.0,
                      ),
                    )
                  : Container()
            ],
          ),
        ),
        onPressed: _reporteLoading
            ? null
            : () {
                _buildReportPDF();
              },
      ),
    );
  }

  _buildReportPDF() async {
    setState(() => _reporteLoading = true);

    String urlRoot = await DirectoryCustom.urlRoot();

    final pathValidate =
        new Directory(urlRoot + DirectoryCustom.pathInventario);

    if (await this._handlePermisos(urlRoot)) {
      if (!(await pathValidate.exists())) {
        await _handleCreateDirectory(urlRoot);
      }

      await Future.delayed(Duration(seconds: 3));

      final pdf = ReportPDF.almacen();

      final file = File(await DirectoryCustom.getNameAlmacen());
      await file.writeAsBytes(await pdf.save());

      SnackBar snackBar = SnackBar(
          content: Text('Reporte Descargado',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
          duration: Duration(seconds: 3),
          backgroundColor: Envinronment.colorSecond);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          snackBar,
        );
      });
      setState(() => _reporteLoading = false);
    }
  }

  Future<bool> _handlePermisos(String pathDirectory) async {
    bool permissionGrant = false;
    try {
      PermissionStatus status = await Permission.storage.status;
      if (status == PermissionStatus.granted) {
        permissionGrant = true;
      } else {
        if (await Permission.storage.request().isGranted) {
          permissionGrant = true;
        } else {
          SnackBar snackBar = SnackBar(
              content: Text(
                  'Permiso denegado. Ir a la configuración de concedido!',
                  style:
                      TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
              duration: Duration(seconds: 3),
              backgroundColor: Envinronment.colorDanger);

          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              snackBar,
            );
          });
          permissionGrant = false;
        }
      }
    } catch (e) {
      SnackBar snackBar = SnackBar(
          content: Text('Error al crear directorio',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
          duration: Duration(seconds: 3),
          backgroundColor: Envinronment.colorDanger);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          snackBar,
        );
      });
      permissionGrant = false;
    }
    return permissionGrant;
  }

  Future _handleCreateDirectory(String externalDirectoryPath) async {
    await DirectoryCustom.create(externalDirectoryPath);
  }

  _buildBody(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    return Container(
        height: queryData.size.height * 0.8,
        width: queryData.size.width,
        child: _refreshRollback
            ? Center(
                child:
                    CircularProgressIndicator(color: Envinronment.colorSecond))
            : RefreshIndicator(
                onRefresh: _handleRefresh,
                child: FutureBuilder(
                    future: almacenProvider.getAlmacenes(),
                    builder: (BuildContext context,
                        AsyncSnapshot<ResponseAlmacen> snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.status) {
                          List<Almacen> almacenes = snapshot.data!.data;

                          return _buildLista(almacenes);
                        } else {
                          ResponseAlmacen response = snapshot.data!;
                          return _buildListaError(response);
                        }
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    }),
              ));
  }

  Widget _buildLista(List<Almacen> almacenes) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: almacenes.length,
      itemBuilder: (context, i) => _item(context, almacenes[i]),
    );
  }

  Widget _buildListaError(ResponseAlmacen response) {
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
                  child: Text('No hay artículos registrados',
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

  Widget _item(BuildContext context, Almacen almacen) {
    return Container(
      margin: EdgeInsets.only(bottom: 5, top: 5, left: 18, right: 18),
      child: Dismissible(
        key: UniqueKey(),
        background: Container(color: Envinronment.colorDanger),
        onDismissed: (direccion) {
          handleDelete(almacen);
        },
        child: Container(
          decoration: BoxDecoration(
              color: Envinronment.colorWhite,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Envinronment.colorBorder),
              boxShadow: [
                BoxShadow(
                  blurRadius: 2.0,
                  color: Colors.black12,
                )
              ]),
          child: ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5,
                ),
                Text(
                  '${almacen.nombre}',
                  style: TextStyle(fontSize: 11),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '${almacen.direccion}',
                  style: TextStyle(fontSize: 11),
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
            onTap: () => Navigator.pushNamed(context, Routes.ALMACEN_CREAR,
                arguments: almacen),
          ),
        ),
      ),
    );
  }

  handleDelete(Almacen almacen) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text('¿Está seguro de eliminar?',
            style: TextStyle(color: Envinronment.colorBlack, fontSize: 14)),
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      side: BorderSide(
                          width: 1.0, color: Envinronment.colorButton),
                      backgroundColor: Envinronment.colorWhite,
                      shape: StadiumBorder(),
                      elevation: 0,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      _handleRefresh();
                    },
                    child: Text('No',
                        style: TextStyle(
                            color: Envinronment.colorBlack,
                            fontWeight: FontWeight.normal))),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Envinronment.colorButton,
                      shape: StadiumBorder(),
                      elevation: 0,
                    ),
                    onPressed: () async {
                      Navigator.pop(context);
                      setState(() => _refreshRollback = true);
                      await almacenProvider.deleteAlmacen(almacen.id);
                      setState(() => _refreshRollback = false);
                      _handleRefresh();
                    },
                    child: Text('Si',
                        style: TextStyle(
                            color: Envinronment.colorBlack,
                            fontWeight: FontWeight.normal)))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<Null> _handleRefresh() async {
    Navigator.pushReplacement(
        context,
        PageRouteBuilder(
            pageBuilder: (a, b, c) => AlmacenPage(),
            transitionDuration: Duration(seconds: 0)));
  }
}
