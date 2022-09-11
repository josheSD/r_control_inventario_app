import 'package:controlinventario/src/core/interfaces/response-inventario.dart';
import 'package:controlinventario/src/core/util/constantes.dart';
import 'package:controlinventario/src/core/util/routes.dart';
import 'package:controlinventario/src/domain/inventario.dart';
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                _lista(context,inventarioProvider)
              ],
            )
          )
    ));
  }
  
  Widget _lista(BuildContext context, InventarioProvider inventarioProvider) {
    MediaQueryData queryData = MediaQuery.of(context);

    return Container(
      height: queryData.size.height * 0.88,
      width: queryData.size.width,
      child: FutureBuilder(
        future: inventarioProvider.getInventarios(),
        builder: (BuildContext context, AsyncSnapshot<ResponseInventario> snapshot){

          if(snapshot.hasData){

            if(snapshot.data!.status){
              List<Inventario> inventarios = snapshot.data!.data;

              return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: inventarios.length,
                itemBuilder: (context,i) => _item(context, inventarios[i]),
              );
              
            }else{

              // Mostrando mensaje
              SnackBar snackBar = SnackBar(
                  content: Text('${snapshot.data!.message}',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold)),
                  duration: Duration(seconds: 2),
                  backgroundColor: Colors.red);
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Scaffold.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(snackBar);
              });

              return Container();

            }

          }else {
            return Center(child: CircularProgressIndicator());
          }

        } 
      )
    );
  }
  
  Widget _item(BuildContext context, Inventario inventario) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(color: Envinronment.colorDanger),
      onDismissed: (direccion) {
        // Borrar item
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 5, top:5, left:10, right:10),
        decoration: BoxDecoration(
          color: Envinronment.colorWhite,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              blurRadius: 2.0,
              color: Colors.black12,
            )
          ]
        ),
        child: ListTile(
          title: Text(
            '${inventario.nombre} - S/. ${inventario.costo}',
          ),
          onTap: () => Navigator.pushNamed(context, Routes.INVENTARIO_CREAR,
              arguments: inventario),
        ),
      ),
    );
  }
}
