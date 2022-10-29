import 'package:flutter/material.dart';

class Envinronment{
  static String urlPersonal = 'https://control-asistencia-personal-ws.azurewebsites.net/personal/api';
  static Color colorPrimary = Color(0xFF898989);
  static Color colorSecond = Color(0xFF2DAAE2);
  static Color colorThird = Color(0xFF7ED7F0);
  static Color colorDanger = Color(0xFFD36363);
  static Color colorWhite = Color(0xFFFFFFFF);
  static Color colorBlack = Color(0xFF000000);
  static Color colorBorder = Color(0xFF999994);
  static Color colorButton = Color(0xFFD3F36B);
  static Color colorBackground = Color(0xFFF6F5EF);
  static Color colorVigente = Color(0xFFCFE2FF);
  static Color colorConcluido = Color(0xFFD1E7DD);
  static Color colorDisabled = Color(0xFFF0F0F0);

  static TextInputType controlText = TextInputType.text;
  static TextInputType controlNumber = TextInputType.number;
  static TextInputType controlCorreo = TextInputType.emailAddress;

  static String API_PERSONAL = 'http://10.0.2.2:7071/personal/api';
  // static String API_PERSONAL = 'https://inventario-personal.azurewebsites.net/personal/api';
  static String API_INVENTARIO = 'http://10.0.2.2:7072/inventario/api';
  // static String API_INVENTARIO = 'https://inventario-inventario.azurewebsites.net/inventario/api';

  static String URL_BLOB = 'https://controlinventario.blob.core.windows.net/articulo/';
  static String URL_SPLIT_IMAGE = '-split-image-';
} 