import 'package:controlinventario/src/core/interfaces/response-proyecto.dart';
import 'package:controlinventario/src/core/interfaces/response-usuario.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../../domain/almacen-form.dart';
import '../../domain/proyecto.dart';
import '../interfaces/response-almacen.dart';
import '../interfaces/response-articulo.dart';

class ReportPDF {
  static Document articulo(ResponseArticulo response) {
    final pdf = Document();
    Row data = new Row();

    for (int i = 0; i < response.data.length; i++) {
      Center(
        child: Text(response.data[i].nombre),
      );
    }

    pdf.addPage(MultiPage(
      build: (context) => <Widget>[
        Center(
            child: Text('Artículos',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25))),
        SizedBox(height: 25),
        for (int i = 0; i < response.data.length; i++)
          Column(children: [
            Row(children: [
              Paragraph(
                  text: "Nombre:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              SizedBox(width: 5),
              Paragraph(
                text: "${response.data[i].nombre}",
                style: TextStyle(fontSize: 18),
              ),
            ]),
            Row(children: [
              Paragraph(
                  text: "Precio:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              SizedBox(width: 5),
              Paragraph(
                text: "${response.data[i].precio}",
                style: TextStyle(fontSize: 18),
              ),
            ]),
            Row(children: [
              Paragraph(
                  text: "Categoria:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              SizedBox(width: 5),
              Paragraph(
                text: "${response.data[i].categoria.nombre}",
                style: TextStyle(fontSize: 18),
              ),
            ]),
            SizedBox(width: 5),
            Row(children: [
              Paragraph(
                  text: "Fecha creación:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              SizedBox(width: 5),
              Paragraph(
                text: "${response.data[i].fechaCreacion}",
                style: TextStyle(fontSize: 18),
              ),
            ]),
            SizedBox(width: 5),
            Row(children: [
              Paragraph(
                  text: "Fecha actualización:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              SizedBox(width: 5),
              Paragraph(
                text: "${response.data[i].fechaActualizacion}",
                style: TextStyle(fontSize: 18),
              ),
            ]),
            SizedBox(height: 20),
          ])
      ],
      footer: (context) {
        final text = 'Pagina ${context.pageNumber} de ${context.pagesCount}';

        return Container(
          alignment: Alignment.centerRight,
          margin: EdgeInsets.only(top: 1 * PdfPageFormat.cm),
          child: Text(
            text,
            style: TextStyle(color: PdfColors.black, fontSize: 18),
          ),
        );
      },
    ));

    return pdf;
  }

  static Document almacen(ResponseAlmacen response) {
    final pdf = Document();
    Row data = new Row();

    for (int i = 0; i < response.data.length; i++) {
      Center(
        child: Text(response.data[i].nombre),
      );
    }

    pdf.addPage(MultiPage(
      build: (context) => <Widget>[
        Center(
            child: Text('Almacén',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25))),
        SizedBox(height: 25),
        for (int i = 0; i < response.data.length; i++)
          Column(children: [
            Row(children: [
              Paragraph(
                  text: "Nombre:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              SizedBox(width: 5),
              Paragraph(
                text: "${response.data[i].nombre}",
                style: TextStyle(fontSize: 18),
              ),
            ]),
            Row(children: [
              Paragraph(
                  text: "Dirección:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              SizedBox(width: 5),
              Paragraph(
                text: "${response.data[i].direccion}",
                style: TextStyle(fontSize: 18),
              ),
            ]),
            Row(children: [
              Paragraph(
                  text: "Fecha creación:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              SizedBox(width: 5),
              Paragraph(
                text: "${response.data[i].fechaCreacion}",
                style: TextStyle(fontSize: 18),
              ),
            ]),
            Row(children: [
              Paragraph(
                  text: "Fecha actualización:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              SizedBox(width: 5),
              Paragraph(
                text: "${response.data[i].fechaActualizacion}",
                style: TextStyle(fontSize: 18),
              ),
            ]),
            Row(children: [
              Paragraph(
                text: "Artículos",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                margin: EdgeInsets.only(left: 210, bottom: 10),
              )
            ]),
            for (int j = 0; j < response.data[i].articulo.length; j++)
              Column(children: [
                Row(children: [
                  Paragraph(
                    text: "Nombre:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    margin: EdgeInsets.only(left: 50),
                  ),
                  SizedBox(width: 5),
                  Paragraph(
                    text: "${response.data[i].articulo[j].nombre}",
                    style: TextStyle(fontSize: 18),
                    margin: EdgeInsets.only(top: 1),
                  ),
                ]),
                SizedBox(height: 5),
                Row(children: [
                  Paragraph(
                    text: "Precio:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    margin: EdgeInsets.only(left: 50),
                  ),
                  SizedBox(width: 5),
                  Paragraph(
                    text: "${response.data[i].articulo[j].precio}",
                    style: TextStyle(fontSize: 18),
                    margin: EdgeInsets.only(top: 1),
                  ),
                ]),
                SizedBox(height: 5),
                Row(children: [
                  Paragraph(
                    text: "Categoria:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    margin: EdgeInsets.only(left: 50),
                  ),
                  SizedBox(width: 5),
                  Paragraph(
                    text: "${response.data[i].articulo[j].categoria.nombre}",
                    style: TextStyle(fontSize: 18),
                    margin: EdgeInsets.only(top: 1),
                  ),
                ]),
                SizedBox(height: 5),
                Row(children: [
                  Paragraph(
                    text: "Fecha creación:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    margin: EdgeInsets.only(left: 50),
                  ),
                  SizedBox(width: 5),
                  Paragraph(
                    text: "${response.data[i].articulo[j].fechaCreacion}",
                    style: TextStyle(fontSize: 18),
                    margin: EdgeInsets.only(top: 1),
                  ),
                ]),
                SizedBox(height: 5),
                Row(children: [
                  Paragraph(
                    text: "Fecha actualización:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    margin: EdgeInsets.only(left: 50),
                  ),
                  SizedBox(width: 5),
                  Paragraph(
                    text: "${response.data[i].articulo[j].fechaActualizacion}",
                    style: TextStyle(fontSize: 18),
                    margin: EdgeInsets.only(top: 1),
                  ),
                ]),
                SizedBox(height: 15),
              ]),
            SizedBox(height: 20),
          ])
      ],
      footer: (context) {
        final text = 'Pagina ${context.pageNumber} de ${context.pagesCount}';

        return Container(
          alignment: Alignment.centerRight,
          margin: EdgeInsets.only(top: 1 * PdfPageFormat.cm),
          child: Text(
            text,
            style: TextStyle(color: PdfColors.black, fontSize: 18),
          ),
        );
      },
    ));

    return pdf;
  }

  static Document proyecto(ResponseProyecto response) {
    final pdf = Document();
    Row data = new Row();

    for (int i = 0; i < response.data.length; i++) {
      Center(
        child: Text(response.data[i].nombre),
      );
    }

    pdf.addPage(MultiPage(
      build: (context) => <Widget>[
        Center(
            child: Text('Proyecto',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25))),
        SizedBox(height: 25),
        for (int i = 0; i < response.data.length; i++)
          Column(children: [
            Row(children: [
              Paragraph(
                  text: "Nombre:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              SizedBox(width: 5),
              Paragraph(
                  text: "${response.data[i].nombre}",
                  style: TextStyle(fontSize: 18)),
            ]),
            Row(children: [
              Paragraph(
                  text: "Cliente:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              SizedBox(width: 5),
              Paragraph(
                  text: "${response.data[i].cliente}",
                  style: TextStyle(fontSize: 18)),
            ]),
            Row(children: [
              Paragraph(
                  text: "Estado:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              SizedBox(width: 5),
              Paragraph(
                  text:
                      "${response.data[i].estado == EProyecto.VIGENTE.index ? 'Vigente' : 'Concluido'}",
                  style: TextStyle(fontSize: 18)),
            ]),
            Row(children: [
              Paragraph(
                  text: "Fecha Inicio:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              SizedBox(width: 5),
              Paragraph(
                  text: "${response.data[i].fechaInicio}",
                  style: TextStyle(fontSize: 18)),
            ]),
            Row(children: [
              Paragraph(
                  text: "Fecha Fin:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              SizedBox(width: 5),
              Paragraph(
                  text: "${response.data[i].fechaFin}",
                  style: TextStyle(fontSize: 18)),
            ]),
            Row(children: [
              Paragraph(
                  text: "Fecha creación:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              SizedBox(width: 5),
              Paragraph(
                  text: "${response.data[i].fechaCreacion}",
                  style: TextStyle(fontSize: 18)),
            ]),
            Row(children: [
              Paragraph(
                  text: "Fecha actualización:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              SizedBox(width: 5),
              Paragraph(
                  text: "${response.data[i].fechaActualizacion}",
                  style: TextStyle(fontSize: 18)),
            ]),
            Row(children: [
              Paragraph(
                text: "Artículos",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                margin: EdgeInsets.only(left: 210, bottom: 10),
              )
            ]),
            for (int j = 0; j < response.data[i].articulo.length; j++)
              Column(children: [
                Row(children: [
                  Paragraph(
                    text: "Nombre:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    margin: EdgeInsets.only(left: 50),
                  ),
                  SizedBox(width: 5),
                  Paragraph(
                    text: "${response.data[i].articulo[j].nombre}",
                    style: TextStyle(fontSize: 18),
                    margin: EdgeInsets.only(top: 1),
                  ),
                ]),
                SizedBox(height: 5),
                Row(children: [
                  Paragraph(
                    text: "Precio:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    margin: EdgeInsets.only(left: 50),
                  ),
                  SizedBox(width: 5),
                  Paragraph(
                    text: "${response.data[i].articulo[j].precio}",
                    style: TextStyle(fontSize: 18),
                    margin: EdgeInsets.only(top: 1),
                  ),
                ]),
                SizedBox(height: 5),
                Row(children: [
                  Paragraph(
                    text: "Categoria:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    margin: EdgeInsets.only(left: 50),
                  ),
                  SizedBox(width: 5),
                  Paragraph(
                    text: "${response.data[i].articulo[j].categoria.nombre}",
                    style: TextStyle(fontSize: 18),
                    margin: EdgeInsets.only(top: 1),
                  ),
                ]),
                SizedBox(height: 5),
                Row(children: [
                  Paragraph(
                    text: "Almacen:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    margin: EdgeInsets.only(left: 50),
                  ),
                  SizedBox(width: 5),
                  Paragraph(
                    text:
                        "${AlmacenForm.fromJson(response.data[i].articulo[j].almacen).nombre}",
                    style: TextStyle(fontSize: 18),
                    margin: EdgeInsets.only(top: 1),
                  ),
                ]),
                SizedBox(height: 5),
                Row(children: [
                  Paragraph(
                    text: "Fecha creación:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    margin: EdgeInsets.only(left: 50),
                  ),
                  SizedBox(width: 5),
                  Paragraph(
                    text: "${response.data[i].articulo[j].fechaCreacion}",
                    style: TextStyle(fontSize: 18),
                    margin: EdgeInsets.only(top: 1),
                  ),
                ]),
                SizedBox(height: 5),
                Row(children: [
                  Paragraph(
                    text: "Fecha actualización:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    margin: EdgeInsets.only(left: 50),
                  ),
                  SizedBox(width: 5),
                  Paragraph(
                    text: "${response.data[i].articulo[j].fechaActualizacion}",
                    style: TextStyle(fontSize: 18),
                    margin: EdgeInsets.only(top: 1),
                  ),
                ]),
                SizedBox(height: 15),
              ]),
            SizedBox(height: 20),
          ])
      ],
      footer: (context) {
        final text = 'Pagina ${context.pageNumber} de ${context.pagesCount}';

        return Container(
          alignment: Alignment.centerRight,
          margin: EdgeInsets.only(top: 1 * PdfPageFormat.cm),
          child: Text(
            text,
            style: TextStyle(color: PdfColors.black, fontSize: 18),
          ),
        );
      },
    ));

    return pdf;
  }

  static Document usuario(ResponseUsuario response) {
    final pdf = Document();
    Row data = new Row();

    for (int i = 0; i < response.data.length; i++) {
      Center(
        child: Text(response.data[i].nombre),
      );
    }

    pdf.addPage(
      MultiPage(
        build: (context) => <Widget>[
          Center(
              child: Text('Usuarios',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25))),
          SizedBox(height: 25),
          for (int i = 0; i < response.data.length; i++)
            Column(children: [
              Row(children: [
                Paragraph(
                    text: "Nombre:",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                SizedBox(width: 5),
                Paragraph(
                  text: "${response.data[i].nombre}",
                ),
              ]),
              Row(children: [
                Paragraph(
                    text: "Direccion:",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                SizedBox(width: 5),
                Paragraph(
                  text: "${response.data[i].direccion}",
                  style: TextStyle(fontSize: 18),
                ),
              ]),
              Row(children: [
                Paragraph(
                    text: "Usuario:",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                SizedBox(width: 5),
                Paragraph(
                  text: "${response.data[i].usuario}",
                  style: TextStyle(fontSize: 18),
                ),
              ]),
              Row(children: [
                Paragraph(
                    text: "Rol:",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                SizedBox(width: 5),
                Paragraph(
                  text: "${response.data[i].rol.nombre}",
                  style: TextStyle(fontSize: 18),
                ),
              ]),
              SizedBox(height: 20),
            ])
        ],
        footer: (context) {
          final text = 'Pagina ${context.pageNumber} de ${context.pagesCount}';

          return Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(top: 1 * PdfPageFormat.cm),
            child: Text(
              text,
              style: TextStyle(color: PdfColors.black, fontSize: 18),
            ),
          );
        },
      ),
    );

    return pdf;
  }
}
