import 'dart:io';

import 'package:controlinventario/src/UI/feature/articulo/articulo_provider.dart';
import 'package:controlinventario/src/UI/feature/usuario/usuario_provider.dart';
import 'package:controlinventario/src/core/interfaces/response-usuario.dart';
import 'package:controlinventario/src/core/util/constantes.dart';
import 'package:controlinventario/src/core/util/routes.dart';
import 'package:controlinventario/src/domain/usuario.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:open_file/open_file.dart';
import '../../../core/util/directory.dart';
import '../../../core/util/report.dart';
import '../../layout/admin/admin_page.dart';

class UsuarioPage extends StatefulWidget {
  @override
  State<UsuarioPage> createState() => _UsuarioPageState();
}

class _UsuarioPageState extends State<UsuarioPage> {
  bool _refreshRollback = false;
  bool _reporteLoading = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late UsuarioProvider usuarioProvider;

  @override
  Widget build(BuildContext context) {
    usuarioProvider = Provider.of<UsuarioProvider>(context, listen: false);

    return Scaffold(
        backgroundColor: Envinronment.colorBackground,
        appBar: AppBar(
          title: Text('Usuario',
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
            Navigator.pushNamed(context, Routes.USUARIO_CREAR);
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

    final pathValidate = new Directory(urlRoot + DirectoryCustom.pathUsuario);

    if (await this._handlePermisos(urlRoot)) {
      if (!(await pathValidate.exists())) {
        await _handleCreateDirectory(urlRoot);
      }

      ResponseUsuario response = await usuarioProvider.getUsuarios();
      final pdf = ReportPDF.usuario(response);

      final file = File(await DirectoryCustom.getNameUsuario());
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
                    future: usuarioProvider.getUsuarios(),
                    builder: (BuildContext context,
                        AsyncSnapshot<ResponseUsuario> snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.status) {
                          List<Usuario> usuarios = snapshot.data!.data;

                          return _buildLista(usuarios);
                        } else {
                          ResponseUsuario response = snapshot.data!;
                          return _buildListaError(response);
                        }
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    }),
              ));
  }

  Widget _buildLista(List<Usuario> usuarios) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: usuarios.length,
      itemBuilder: (context, i) => _item(context, usuarios[i]),
    );
  }

  Widget _buildListaError(ResponseUsuario response) {
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

  Widget _item(BuildContext context, Usuario usuario) {
    return Container(
      margin: EdgeInsets.only(bottom: 5, top: 5, left: 18, right: 18),
      child: Dismissible(
        key: UniqueKey(),
        background: Container(color: Envinronment.colorDanger),
        onDismissed: (direccion) {
          handleDelete(usuario);
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
                  '${usuario.nombre}',
                  style: TextStyle(fontSize: 11),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '${usuario.direccion}',
                  style: TextStyle(fontSize: 11),
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
            onTap: () => Navigator.pushNamed(context, Routes.USUARIO_CREAR,
                arguments: usuario),
          ),
        ),
      ),
    );
  }

  handleDelete(Usuario usuario) {
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
                      await usuarioProvider.deleteUsuario(usuario.id);
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
            pageBuilder: (a, b, c) => UsuarioPage(),
            transitionDuration: Duration(seconds: 0)));
  }
}
