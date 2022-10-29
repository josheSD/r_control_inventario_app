import 'dart:io';

import 'package:controlinventario/src/UI/feature/articulo/articulo_provider.dart';
import 'package:controlinventario/src/core/interfaces/response-articulo.dart';
import 'package:controlinventario/src/core/util/constantes.dart';
import 'package:controlinventario/src/core/util/directory.dart';
import 'package:controlinventario/src/core/util/report.dart';
import 'package:controlinventario/src/core/util/routes.dart';
import 'package:controlinventario/src/domain/articulo.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:external_path/external_path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:open_file/open_file.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../layout/admin/admin_page.dart';

class ArticuloPage extends StatefulWidget {
  @override
  State<ArticuloPage> createState() => _ArticuloPageState();
}

class _ArticuloPageState extends State<ArticuloPage> {
  bool _refreshRollback = false;
  bool _reporteLoading = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late ArticuloProvider articuloProvider;

  @override
  Widget build(BuildContext context) {
    articuloProvider = Provider.of<ArticuloProvider>(context, listen: false);

    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Envinronment.colorBackground,
        appBar: AppBar(
          title: Text('Artículo',
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
                Navigator.pop(context,Routes.ADMIN);
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
            Navigator.pushNamed(context, Routes.ARTICULO_CREAR);
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

    final pathValidate =
        new Directory(urlRoot + DirectoryCustom.pathInventario);

    if (await this._handlePermisos(urlRoot)) {
      if (!(await pathValidate.exists())) {
        await _handleCreateDirectory(urlRoot);
      }

      ResponseArticulo response = await articuloProvider.getArticulos();

      final pdf = ReportPDF.articulo(response);

      final file = File(await DirectoryCustom.getNameArticulo());
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
                    future: articuloProvider.getArticulos(),
                    builder: (BuildContext context,
                        AsyncSnapshot<ResponseArticulo> snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.status) {
                          List<Articulo> articulos = snapshot.data!.data;
                          return _buildLista(articulos);
                        } else {
                          ResponseArticulo response = snapshot.data!;
                          return _buildListaError(response);
                        }
                      } else {
                        return Center(
                            child: CircularProgressIndicator(
                                color: Envinronment.colorSecond));
                      }
                    }),
              ));
  }

  Widget _buildLista(List<Articulo> articulos) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: articulos.length,
      itemBuilder: (context, i) => _item(context, articulos[i]),
    );
  }

  Widget _buildListaError(ResponseArticulo response) {
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

  Widget _item(
    BuildContext context,
    Articulo articulo,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 5, top: 5, left: 18, right: 18),
      child: Dismissible(
        key: UniqueKey(),
        background: Container(color: Envinronment.colorDanger),
        onDismissed: (direccion) {
          handleDelete(articulo);
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
                  '${articulo.nombre}',
                  style: TextStyle(fontSize: 11),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '${articulo.categoria.nombre}',
                  style: TextStyle(fontSize: 11),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'S/. ${articulo.precio}',
                  style: TextStyle(fontSize: 11),
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
            onTap: () async {
              context.loaderOverlay.show();
              await articuloProvider.initializeImagen(articulo);
              Navigator.pushNamed(context, Routes.ARTICULO_CREAR,
                  arguments: articulo);
              context.loaderOverlay.hide();
            },
          ),
        ),
      ),
    );
  }

  handleDelete(Articulo articulo) {
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
                      await articuloProvider.deleteArticulo(articulo.id);
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
            pageBuilder: (a, b, c) => ArticuloPage(),
            transitionDuration: Duration(seconds: 0)));
  }
}
