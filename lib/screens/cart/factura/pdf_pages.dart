import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:shop_app/models/producto_model.dart';
import 'package:shop_app/screens/cart/factura/util/util.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:http/http.dart' as http;
import '../../../models/carrito_model.dart';
import 'dart:math';

class PdfPage extends StatefulWidget {
  final List<ProductoModel> model;
  final double total;
  const PdfPage({super.key, required this.model, required this.total});

  @override
  State<PdfPage> createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  PrintingInfo? printingInfo;

  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final info = await Printing.info();
    setState(() {
      printingInfo = info;
    });
  }
  Future<void> postInvoice(User user, List<CarritoModel> models) async {
    try {
      // Generar el PDF
      final pdfBytes = await generatePdf(PdfPageFormat.a4);

      // Convertir el PDF a un archivo temporal
      final tempDir = await getTemporaryDirectory();
      final pdfFile = File('${tempDir.path}/invoice.pdf');
      await pdfFile.writeAsBytes(pdfBytes);

      // Crear la solicitud POST
      final url = Uri.parse('URL_DE_TU_API'); // Reemplaza esto con la URL de tu API
      final request = http.MultipartRequest('POST', url)
        ..files.add(await http.MultipartFile.fromPath('invoice', pdfFile.path))
        ..fields['userId'] = user.uid;

      // Enviar la solicitud
      final response = await request.send();

      // Verificar el estado de la respuesta
      if (response.statusCode == 200) {
        print('Reserva enviada con éxito.');
      } else {
        print('Error al enviar la factura: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error al enviar la factura: $e');
    }
  }

  Future<Uint8List> generatePdf(final PdfPageFormat format) async {

    final doc = pw.Document(title: "Reserva");
    final logoImage = pw.MemoryImage(
        (await rootBundle.load("assets/sena.png")).buffer.asUint8List());

    final pageTheme = await myPageTheme(format);
    User? user = FirebaseAuth.instance.currentUser;
    Random random = Random();
    int randomNumber = random.nextInt(1000000);
    DateTime now = DateTime.now();
    DateTime tomorrow = now.add(Duration(hours: 8));
    String formatDate(DateTime dateTime) {
      String formattedDate =
          "${dateTime.year.toString().padLeft(4, '0')}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
      return formattedDate;
    }

    String formattedNow = formatDate(now);
    String formattedTomorrow = formatDate(tomorrow);

    doc.addPage(
      pw.MultiPage(
          pageTheme: pageTheme,
          header: (final context) => pw.Image(
              alignment: pw.Alignment.topLeft,
              logoImage,
              fit: pw.BoxFit.contain,
              width: 100),
          build: (context) => [
                pw.Container(
                    padding: pw.EdgeInsets.only(left: 30, bottom: 20),
                    child: pw.Row(
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.end,
                              children: [
                                pw.Text('Email: '),
                                pw.Text('Telefono: '),
                                pw.Text('Cliente Correo: '),
                                pw.Text("Numero de factura: "),
                                pw.Text("Fecha de inicio: "),
                                pw.Text("Fecha de expiracion: ")
                              ]),
                          pw.SizedBox(width: 70),
                          pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text('sena@misena.com'),
                                pw.Text('032131 03123'),
                                pw.Text("${user?.email}"),
                                pw.Text("$randomNumber"),
                                pw.Text(formattedNow),
                                pw.Text(formattedTomorrow)

                              ]),
                          pw.SizedBox(width: 70),
                          pw.BarcodeWidget(
                              data: "Su pedido se ha realizado con exito! tiene un plazo de 8 horas ($formattedNow - $formattedTomorrow) para reclamar sus productos , costo total de \$${widget.total}",
                              width: 160,
                              height: 160,
                              barcode: pw.Barcode.qrCode(),
                              drawText: false),
                          pw.Padding(padding: pw.EdgeInsets.zero)
                        ])),
                pw.Center(
                  child: pw.Padding(
                padding: pw.EdgeInsets.only(bottom: 15),
                      child: pw.Text('Reserva',
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold, fontSize: 30))
    )
                    ),
                for (var item in widget.model)

                  pw.Container(
                    padding:
                        pw.EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    margin: pw.EdgeInsets.only(bottom: 10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: PdfColors.black),
                    ),
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(item.productoName!),
                        pw.Text(
                            "\$${item.productoPrice} x ${item.counter}"),
                        pw.Text("\$${item.subtotal}"),
                      ],
                    ),
                  ),
                pw.Container(
                  padding:
                      pw.EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  margin: pw.EdgeInsets.only(bottom: 10),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: PdfColors.black),
                  ),
                  child:
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('Total:'),
                      pw.Text(
                          "\$${widget.model!
        .map((carrito) => int.parse(carrito.subtotal!))
        .fold(0, (a, b) => a + b)}"),
                    ],
                  ),
                )
              ]),
    );

    return doc.save();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reserva"),
      ),
      body: PdfPreview(
        maxPageWidth: 700,
        actions: [],
        onPrinted: showPrintedToast,
        onShared: showSharedToast,
        build: generatePdf,
      ),
    );
  }
}
