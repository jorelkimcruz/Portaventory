import 'package:flutter/material.dart';
import 'package:portaventory/pages/qr_code_view/qr_code_view_controller.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../helpers/exported_packages.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class QRCodeView extends GetView<QRCodeViewController> {
  const QRCodeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller;
    return Scaffold(
        appBar: AppBarWidget(
          title: controller.item.name ?? 'QR Code',
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            QrImage(
              data: controller.qrdata,
              version: QrVersions.auto,
              gapless: true,
              foregroundColor: Theme.of(context).textTheme.bodyMedium!.color,
            ),
            TextButton.icon(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green)),
              onPressed: () async {
                final image = await QrPainter(
                  data: controller.qrdata,
                  version: QrVersions.auto,
                  gapless: false,
                ).toImageData(200);
                final imagemem = MemoryImage(image!.buffer.asUint8List());
                final doc = pw.Document();
                final sd = await flutterImageProvider(imagemem);

                doc.addPage(pw.Page(build: (pw.Context context) {
                  return pw.Center(
                      child: pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.center,
                          children: [
                        pw.Image(sd),
                        pw.Text(controller.item.name!,
                            style: const pw.TextStyle(fontSize: 30)),
                      ]));
                }));
                await Printing.layoutPdf(
                    onLayout: (format) async => doc.save());
              },
              label: const Text('Print QR Code'),
              icon: const Icon(Icons.print),
            )
          ],
        ));
  }
}
