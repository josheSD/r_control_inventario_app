import 'dart:io';

import 'package:controlinventario/src/UI/feature/proyecto/proyecto_provider.dart';
import 'package:controlinventario/src/core/interfaces/response-proyecto.dart';
import 'package:controlinventario/src/core/util/constantes.dart';
import 'package:controlinventario/src/core/util/routes.dart';
import 'package:controlinventario/src/domain/proyecto.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../../core/util/directory.dart';
import '../../../core/util/report.dart';
import 'package:open_file/open_file.dart';

import '../../layout/admin/admin_page.dart';
import 'package:loader_overlay/loader_overlay.dart';

class ProyectoPage extends StatefulWidget {
  @override
  State<ProyectoPage> createState() => _ProyectoPageState();
}

class _ProyectoPageState extends State<ProyectoPage> {
  bool _refreshRollback = false;
  bool _reporteLoading = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late ProyectoProvider proyectoProvider;

  @override
  Widget build(BuildContext context) {
    proyectoProvider = Provider.of<ProyectoProvider>(context, listen: false);

    return Scaffold(
        backgroundColor: Envinronment.colorBackground,
        appBar: AppBar(
          title: Text('Proyecto',
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
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => AdminPage()),
                  (Route<dynamic> route) => false,
                );
              },
            );
          }),
        ),
        body: Container(
            child: SingleChildScrollView(
                child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_buildReporte(context), _buildBody(context)],
        ))),
        floatingActionButton: FloatingActionButton(
          elevation: 2,
          backgroundColor: Envinronment.colorButton,
          child: Icon(FontAwesomeIcons.plus,
              color: Envinronment.colorBlack, size: 24),
          onPressed: () {
            Navigator.pushNamed(context, Routes.PROYECTO_CREAR);
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
    context.loaderOverlay.show();

    String urlRoot = await DirectoryCustom.urlRoot();

    final pathValidate = new Directory(urlRoot + DirectoryCustom.pathProyecto);

    if (await this._handlePermisos(urlRoot)) {
      if (!(await pathValidate.exists())) {
        await _handleCreateDirectory(urlRoot);
      }

      ResponseProyecto response = await proyectoProvider.getProyectos();
      final pdf = ReportPDF.proyecto(response);

      final file = File(await DirectoryCustom.getNameProyecto());
      await file.writeAsBytes(await pdf.save());

      await OpenFile.open(file.path);

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
      context.loaderOverlay.hide();
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
                    future: proyectoProvider.getProyectos(),
                    builder: (BuildContext context,
                        AsyncSnapshot<ResponseProyecto> snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.status) {
                          List<Proyecto> proyectos = snapshot.data!.data;

                          return _buildLista(proyectos);
                        } else {
                          ResponseProyecto response = snapshot.data!;
                          return _buildListaError(response);
                        }
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    }),
              ));
  }

  Widget _buildLista(List<Proyecto> proyectos) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: proyectos.length,
      itemBuilder: (context, i) => _item(context, proyectos[i]),
    );
  }

  Widget _buildListaError(ResponseProyecto response) {
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

  Widget _item(BuildContext context, Proyecto proyecto) {
    return Container(
      margin: EdgeInsets.only(bottom: 5, top: 5, left: 18, right: 18),
      child: Dismissible(
        key: UniqueKey(),
        background: Container(color: Envinronment.colorDanger),
        onDismissed: (direccion) {
          handleDelete(proyecto);
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
                  '${proyecto.nombre}',
                  style: TextStyle(fontSize: 11),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '${proyecto.cliente}',
                  style: TextStyle(fontSize: 11),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          color: proyecto.estado == EProyecto.VIGENTE.index
                              ? Envinronment.colorVigente
                              : Envinronment.colorConcluido,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Text(
                        textAlign: TextAlign.end,
                        proyecto.estado == EProyecto.VIGENTE.index
                            ? EProyecto.VIGENTE.name
                            : EProyecto.CONCLUIDO.name,
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
            onTap: () => Navigator.pushNamed(context, Routes.PROYECTO_CREAR,
                arguments: proyecto),
          ),
        ),
      ),
    );
  }

  handleDelete(Proyecto proyecto) {
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
                      await proyectoProvider.deleteProyecto(proyecto.id);
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
            pageBuilder: (a, b, c) => ProyectoPage(),
            transitionDuration: Duration(seconds: 0)));
  }
}
