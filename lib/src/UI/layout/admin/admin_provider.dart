import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AdminProvider with ChangeNotifier {

  int _paginaActual = 0;

  get paginaActual {
    return _paginaActual;
  }

  set setPaginaActual(int paginaActual){
    _paginaActual = paginaActual;
    notifyListeners();
  }

}
