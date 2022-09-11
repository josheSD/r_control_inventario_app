import 'package:controlinventario/src/core/util/constantes.dart';
import 'package:controlinventario/src/domain/tipo.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class Input {
  static Widget control(String formControlName, String labelText,
      String errorText, bool isContrasenia, TextInputType type) {
    return ReactiveTextField(
      formControlName: formControlName,
      textInputAction: TextInputAction.next,
      validationMessages: {ValidationMessage.required: (error) => errorText},
      obscureText: isContrasenia,
      cursorColor: Envinronment.colorPrimary,
      keyboardType: type,
      style: TextStyle(
          color: Envinronment.colorPrimary,
          decorationColor: Envinronment.colorPrimary),
      decoration: InputDecoration(
          labelText: labelText,
          labelStyle: new TextStyle(color: Envinronment.colorPrimary),
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
    );
  }

  static Widget select(String formControlName, String labelText,
      String errorText, List<TipoInventario> tipoInventario) {

    return ReactiveDropdownField(
      items: tipoInventario.map<DropdownMenuItem<String>>((TipoInventario value) {
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
          labelText: labelText,
          labelStyle: new TextStyle(color: Envinronment.colorPrimary),
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
    );
  }
}
