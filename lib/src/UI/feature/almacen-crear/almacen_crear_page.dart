import 'package:controlinventario/src/core/util/constantes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AlmacenCrearPage extends StatefulWidget {

  @override
  State<AlmacenCrearPage> createState() => _AlmacenCrearPageState();
}

class _AlmacenCrearPageState extends State<AlmacenCrearPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          
        ],
      ))),
    );
  }
}
