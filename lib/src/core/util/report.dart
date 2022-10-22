import 'package:controlinventario/src/core/interfaces/response-proyecto.dart';
import 'package:controlinventario/src/core/interfaces/response-usuario.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../../domain/usuario.dart';
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
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
        SizedBox(height: 25),
        for (int i = 0; i < response.data.length; i++)
          Column(children: [
            Row(children: [
              Paragraph(
                  text: "Nombre:",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(width: 5),
              Paragraph(
                text: "${response.data[i].nombre}",
              ),
            ]),
            Row(children: [
              Paragraph(
                  text: "Precio:",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(width: 5),
              Paragraph(
                text: "${response.data[i].precio}",
              ),
            ]),
            Row(children: [
              Paragraph(
                  text: "Categoria:",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(width: 5),
              Paragraph(
                text: "${response.data[i].categoria.nombre}",
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
            style: TextStyle(color: PdfColors.black),
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
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
        SizedBox(height: 25),
        for (int i = 0; i < response.data.length; i++)
          Column(children: [
            Row(children: [
              Paragraph(
                  text: "Nombre:",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(width: 5),
              Paragraph(
                text: "${response.data[i].nombre}",
              ),
            ]),
            Row(children: [
              Paragraph(
                  text: "Dirección:",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(width: 5),
              Paragraph(
                text: "${response.data[i].direccion}",
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
            style: TextStyle(color: PdfColors.black),
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
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
        SizedBox(height: 25),
        for (int i = 0; i < response.data.length; i++)
          Column(children: [
            Row(children: [
              Paragraph(
                  text: "Nombre:",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(width: 5),
              Paragraph(
                text: "${response.data[i].nombre}",
              ),
            ]),
            Row(children: [
              Paragraph(
                  text: "Cliente:",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(width: 5),
              Paragraph(
                text: "${response.data[i].cliente}",
              ),
            ]),
            Row(children: [
              Paragraph(
                  text: "Fecha Inicio:",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(width: 5),
              Paragraph(
                text: "${response.data[i].fechaInicio}",
              ),
            ]),
            Row(children: [
              Paragraph(
                  text: "Fecha Fin:",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(width: 5),
              Paragraph(
                text: "${response.data[i].fechaFin}",
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
            style: TextStyle(color: PdfColors.black),
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
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
          SizedBox(height: 25),
          for (int i = 0; i < response.data.length; i++)
            Column(children: [
              Row(children: [
                Paragraph(
                    text: "Nombre:",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(width: 5),
                Paragraph(
                  text: "${response.data[i].nombre}",
                ),
              ]),
              Row(children: [
                Paragraph(
                    text: "Direccion:",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(width: 5),
                Paragraph(
                  text: "${response.data[i].direccion}",
                ),
              ]),
              Row(children: [
                Paragraph(
                    text: "Usuario:",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(width: 5),
                Paragraph(
                  text: "${response.data[i].usuario}",
                ),
              ]),
              Row(children: [
                Paragraph(
                    text: "Rol:",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(width: 5),
                Paragraph(
                  text: "${response.data[i].rol.nombre}",
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
              style: TextStyle(color: PdfColors.black),
            ),
          );
        },
      ),
    );

    return pdf;
  }
}
