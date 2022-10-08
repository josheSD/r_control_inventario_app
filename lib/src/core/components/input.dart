import 'package:controlinventario/src/core/util/constantes.dart';
import 'package:controlinventario/src/domain/articulo.dart';
import 'package:controlinventario/src/domain/categoria.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class Input {
  static Widget control(
      {required String formControlName,
      required String labelText,
      required String errorText,
      required bool isContrasenia,
      required TextInputType type}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(margin: EdgeInsets.only(bottom: 6), child: Text(labelText)),
        ReactiveTextField(
          formControlName: formControlName,
          textInputAction: TextInputAction.next,
          validationMessages: {
            ValidationMessage.required: (error) => errorText
          },
          obscureText: isContrasenia,
          cursorColor: Envinronment.colorPrimary,
          keyboardType: type,
          style: TextStyle(
            color: Envinronment.colorPrimary,
            decorationColor: Envinronment.colorPrimary,
          ),
          decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.all(9),
              filled: true,
              fillColor: Envinronment.colorWhite,
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Envinronment.colorDanger),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Envinronment.colorPrimary),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Envinronment.colorDanger),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Envinronment.colorPrimary),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Envinronment.colorPrimary),
              )),
        ),
      ],
    );
  }

  static Widget selectCategoria(
      {required String formControlName,
      required String labelText,
      required String errorText,
      required List<Categoria> categorias}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(margin: EdgeInsets.only(bottom: 6), child: Text(labelText)),
        ReactiveDropdownField(
          items:
              categorias.map<DropdownMenuItem<String>>((Categoria value) {
            return DropdownMenuItem<String>(
              value: value.id.toString(),
              child: Text(value.nombre),
            );
          }).toList(),
          formControlName: formControlName,
          validationMessages: {ValidationMessage.required: (error) => errorText},
          style: TextStyle(
              color: Envinronment.colorPrimary,
              decorationColor: Envinronment.colorPrimary),
          decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.all(9),
              filled: true,
              fillColor: Envinronment.colorWhite,
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Envinronment.colorDanger),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Envinronment.colorPrimary),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Envinronment.colorDanger),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Envinronment.colorPrimary),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Envinronment.colorPrimary),
              )),
        ),
      ],
    );
  }

  static Widget selectArticulo(
      {required String formControlName,
      required String labelText,
      required String errorText,
      required List<Articulo> articulos}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(margin: EdgeInsets.only(bottom: 6), child: Text(labelText)),
        ReactiveDropdownField(
          items:
              articulos.map<DropdownMenuItem<String>>((Articulo value) {
            return DropdownMenuItem<String>(
              value: value.id.toString(),
              child: Text(value.nombre),
            );
          }).toList(),
          formControlName: formControlName,
          validationMessages: {ValidationMessage.required: (error) => errorText},
          style: TextStyle(
              color: Envinronment.colorPrimary,
              decorationColor: Envinronment.colorPrimary),
          decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.all(9),
              filled: true,
              fillColor: Envinronment.colorWhite,
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Envinronment.colorDanger),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Envinronment.colorPrimary),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Envinronment.colorDanger),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Envinronment.colorPrimary),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Envinronment.colorPrimary),
              )),
        ),
      ],
    );
  }

}
