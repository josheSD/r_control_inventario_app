import 'dart:io';

import 'package:external_path/external_path.dart';

class DirectoryCustom {
  static String pathInventario = '/ControlInventario';
  static String pathArticulo = '$pathInventario/ReporteArticulo';
  static String pathAlmacen = '$pathInventario/ReporteAlmacen';
  static String pathProyecto = '$pathInventario/ReporteProyecto';
  static String pathUsuario = '$pathInventario/ReporteUsuario';

  static Future<String> urlRoot() async {
    return await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_DCIM);
  }

  static Future<String> getNameArticulo() async {
    String pathDirectory = await DirectoryCustom.urlRoot();
    return "$pathDirectory$pathArticulo/reporte-articulo-${DateTime.now()}.pdf";
  }

  static Future<String> getNameAlmacen() async {
    String pathDirectory = await DirectoryCustom.urlRoot();
    return "$pathDirectory$pathAlmacen/reporte-almacen-${DateTime.now()}.pdf";
  }

  static Future<String> getNameProyecto() async {
    String pathDirectory = await DirectoryCustom.urlRoot();
    return "$pathDirectory$pathProyecto/reporte-proyecto-${DateTime.now()}.pdf";
  }

  static Future<String> getNameUsuario() async {
    String pathDirectory = await DirectoryCustom.urlRoot();
    return "$pathDirectory$pathUsuario/reporte-usuario-${DateTime.now()}.pdf";
  }

  static create(String externalDirectoryPath) async {
    await new Directory(externalDirectoryPath + DirectoryCustom.pathInventario)
        .create()
        .then((Directory directory) {});
    await new Directory(externalDirectoryPath + DirectoryCustom.pathArticulo)
        .create()
        .then((Directory directory) {});
    await new Directory(externalDirectoryPath + DirectoryCustom.pathAlmacen)
        .create()
        .then((Directory directory) {});
    await new Directory(externalDirectoryPath + DirectoryCustom.pathProyecto)
        .create()
        .then((Directory directory) {});
    await new Directory(externalDirectoryPath + DirectoryCustom.pathUsuario)
        .create()
        .then((Directory directory) {});
  }
}
