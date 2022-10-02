import 'package:controlinventario/src/UI/feature/proyecto/proyecto_provider.dart';
import 'package:controlinventario/src/core/interfaces/response-proyecto.dart';
import 'package:controlinventario/src/core/util/constantes.dart';
import 'package:controlinventario/src/core/util/routes.dart';
import 'package:controlinventario/src/domain/proyecto.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ProyectoPage extends StatefulWidget {
  const ProyectoPage({super.key});

  @override
  State<ProyectoPage> createState() => _ProyectoPageState();
}

class _ProyectoPageState extends State<ProyectoPage> {
  @override
  Widget build(BuildContext context) {
    final proyectoProvider =
        Provider.of<ProyectoProvider>(context, listen: false);

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
            _buildReporte(context, proyectoProvider),
            _buildBody(context, proyectoProvider)
          ],
        ))),
        floatingActionButton: FloatingActionButton(
          elevation: 2,
          mini: true,
          backgroundColor: Envinronment.colorButton,
          child: Icon(FontAwesomeIcons.plus,
              color: Envinronment.colorBlack, size: 24),
          onPressed: () {},
        ));
  }

  _buildReporte(BuildContext context, ProyectoProvider proyectoProvider) {
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

  _buildBody(BuildContext context, ProyectoProvider proyectoProvider) {
    MediaQueryData queryData = MediaQuery.of(context);
    return Container(
        height: queryData.size.height * 0.8,
        width: queryData.size.width,
        child: FutureBuilder(
            future: proyectoProvider.getProyectos(),
            builder: (BuildContext context,
                AsyncSnapshot<ResponseProyecto> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.status) {
                  List<Proyecto> almacenes = snapshot.data!.data;

                  return _buildLista(almacenes);
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

  Widget _buildLista(List<Proyecto> proyectos) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: proyectos.length,
      itemBuilder: (context, i) => _item(context, proyectos[i]),
    );
  }

  Widget _item(BuildContext context, Proyecto proyecto) {
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
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
            onTap: () => Navigator.pushNamed(context, Routes.PROYECTO,
                arguments: proyecto),
          ),
        ),
      ),
    );
  }
}
