import 'package:controlinventario/src/core/util/constantes.dart';
import 'package:controlinventario/src/domain/almacen.dart';
import 'package:controlinventario/src/domain/articulo.dart';
import 'package:controlinventario/src/domain/categoria.dart';
import 'package:controlinventario/src/domain/rol.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
          items: categorias.map<DropdownMenuItem<String>>((Categoria value) {
            return DropdownMenuItem<String>(
              value: value.id.toString(),
              child: Text(value.nombre),
            );
          }).toList(),
          formControlName: formControlName,
          validationMessages: {
            ValidationMessage.required: (error) => errorText
          },
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
          items: articulos.map<DropdownMenuItem<String>>((Articulo value) {
            return DropdownMenuItem<String>(
              value: value.id.toString(),
              child: Text(value.nombre),
            );
          }).toList(),
          formControlName: formControlName,
          validationMessages: {
            ValidationMessage.required: (error) => errorText
          },
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

  static Widget selectAlmacen(
      {required String formControlName,
      required String labelText,
      required String errorText,
      required List<Almacen> almacenes}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(margin: EdgeInsets.only(bottom: 6), child: Text(labelText)),
        ReactiveDropdownField(
          items: almacenes.map<DropdownMenuItem<String>>((Almacen value) {
            return DropdownMenuItem<String>(
              value: value.id.toString(),
              child: Text(value.nombre),
            );
          }).toList(),
          formControlName: formControlName,
          validationMessages: {
            ValidationMessage.required: (error) => errorText
          },
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

  static Widget selectRol(
      {required String formControlName,
      required String labelText,
      required String errorText,
      required List<Rol> roles,
      required ValueChanged<bool> onClicked}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: EdgeInsets.only(bottom: 6),
            child: Row(
              children: [
                Text(labelText),
                GestureDetector(
                    onTap: () =>{
                      onClicked(true)
                    },
                    child: InkWell(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 2),
                        child: Icon(FontAwesomeIcons.circleQuestion,
                            size: 12, color: Envinronment.colorDanger),
                      ),
                    ))
              ],
            )),
        ReactiveDropdownField(
          items: roles.map<DropdownMenuItem<String>>((Rol value) {
            return DropdownMenuItem<String>(
              value: value.id.toString(),
              child: Text(value.nombre),
            );
          }).toList(),
          formControlName: formControlName,
          validationMessages: {
            ValidationMessage.required: (error) => errorText
          },
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

  static Widget calendar(
      {required String formControlName,
      required String labelText,
      required String errorText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(margin: EdgeInsets.only(bottom: 6), child: Text(labelText)),
        ReactiveDatePicker(
          formControlName: formControlName,
          builder: (context, picker, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(children: [
                  GestureDetector(
                    onTap: picker.showPicker,
                    child: Container(
                        height: 36,
                        width: double.infinity,
                        padding: EdgeInsets.only(top: 10, left: 45),
                        decoration: BoxDecoration(
                            color: Envinronment.colorWhite,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                                color: picker.control.hasErrors &&
                                        (picker.control.dirty ||
                                            picker.control.touched)
                                    ? Envinronment.colorDanger
                                    : Envinronment.colorBorder)),
                        child: Text(
                            picker.value.toString() == 'null'
                                ? ''
                                : picker.value.toString(),
                            style: TextStyle(
                              color: Envinronment.colorPrimary,
                              decorationColor: Envinronment.colorPrimary,
                            ))),
                  ),
                  Positioned(
                    top: -6,
                    left: 2,
                    child: IconButton(
                      onPressed: picker.showPicker,
                      icon: Icon(Icons.date_range),
                    ),
                  ),
                ]),
                picker.control.hasErrors &&
                        (picker.control.dirty || picker.control.touched)
                    ? Container(
                        margin: EdgeInsets.only(top: 8, left: 10),
                        child: Text(errorText,
                            style: TextStyle(
                                color: Envinronment.colorDanger, fontSize: 12)))
                    : Container()
              ],
            );
          },
          firstDate: DateTime.parse('2000-01-01'),
          lastDate: DateTime.parse('2040-12-29'),
        ),
      ],
    );
  }
}
