import 'package:controlinventario/src/core/util/constantes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProyectoConcludioPage extends StatefulWidget {
  const ProyectoConcludioPage({super.key});

  @override
  State<ProyectoConcludioPage> createState() => _ProyectoConcludioPageState();
}

class _ProyectoConcludioPageState extends State<ProyectoConcludioPage> {
  @override
  Widget build(BuildContext context) {
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
        body: Text('Hola'));
  }
}
