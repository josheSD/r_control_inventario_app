import 'package:controlinventario/src/UI/feature/articulo/articulo_provider.dart';
import 'package:controlinventario/src/UI/feature/usuario/usuario_provider.dart';
import 'package:controlinventario/src/core/interfaces/response-usuario.dart';
import 'package:controlinventario/src/core/util/constantes.dart';
import 'package:controlinventario/src/core/util/routes.dart';
import 'package:controlinventario/src/domain/usuario.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class UsuarioPage extends StatefulWidget {
  @override
  State<UsuarioPage> createState() => _UsuarioPageState();
}

class _UsuarioPageState extends State<UsuarioPage> {
  @override
  Widget build(BuildContext context) {
    final usuarioProvider =
        Provider.of<UsuarioProvider>(context, listen: false);

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
            _buildReporte(context, usuarioProvider),
            _buildBody(context, usuarioProvider)
          ],
        ))),
        floatingActionButton: FloatingActionButton(
          elevation: 2,
          mini: true,
          backgroundColor: Envinronment.colorButton,
          child: Icon(FontAwesomeIcons.plus,
              color: Envinronment.colorBlack, size: 24),
          onPressed: () {
            Navigator.pushNamed(context, Routes.USUARIO_CREAR);
          },
        ));
  }

  _buildReporte(BuildContext context, UsuarioProvider usuarioProvider) {
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
            ],
          ),
        ),
        onPressed: () => {},
      ),
    );
  }

  _buildBody(BuildContext context, UsuarioProvider usuarioProvider) {
    MediaQueryData queryData = MediaQuery.of(context);
    return Container(
        height: queryData.size.height * 0.8,
        width: queryData.size.width,
        child: FutureBuilder(
            future: usuarioProvider.getUsuarios(),
            builder: (BuildContext context,
                AsyncSnapshot<ResponseUsuario> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.status) {
                  List<Usuario> usuarios = snapshot.data!.data;

                  return _buildLista(usuarios);
                } else {
                  // Mostrando mensaje
                  SnackBar snackBar = SnackBar(
                      content: Text('${snapshot.data!.message}',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold)),
                      duration: Duration(seconds: 2),
                      backgroundColor: Envinronment.colorDanger);
                  // WidgetsBinding.instance.addPostFrameCallback((_) {
                  //   Scaffold.of(context)
                  //     ..hideCurrentSnackBar()
                  //     ..showSnackBar(snackBar);
                  // });

                  return Container();
                }
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }

  Widget _buildLista(List<Usuario> usuarios) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: usuarios.length,
      itemBuilder: (context, i) => _item(context, usuarios[i]),
    );
  }

  Widget _item(BuildContext context, Usuario usuario) {
    return Container(
      margin: EdgeInsets.only(bottom: 5, top: 5, left: 18, right: 18),
      child: Dismissible(
        key: UniqueKey(),
        background: Container(color: Envinronment.colorDanger),
        onDismissed: (direccion) {
          // Borrar item
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
}
