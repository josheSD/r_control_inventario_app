import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ReportPDF {
  static pw.Document articulo() {
    final pdf = pw.Document();

    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text("Reporte de artículo"),
          ); // Center
        })); // Page

    return pdf;
  }
  static pw.Document almacen() {
    final pdf = pw.Document();

    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text("Reporte de almacen"),
          ); // Center
        })); // Page

    return pdf;
  }
}
