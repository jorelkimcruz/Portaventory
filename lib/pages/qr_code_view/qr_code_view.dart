import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:portaventory/gen/assets.gen.dart';
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
        appBar: const AppBarWidget(
          title: 'QR Code',
          actions: [],
        ),
        body: Column(
          children: [
            QrImage(
              data: controller.qrdata,
              version: QrVersions.auto,
              gapless: true,
              foregroundColor: Colors.white,
            ),
            TextButton(
                onPressed: () async {
                  final painter = QrPainter.withQr(
                    qr: qrCode,
                    color: const Color(0xFF000000),
                    gapless: true,
                    embeddedImageStyle: null,
                    embeddedImage: null,
                  );
                  final doc = pw.Document();
                  final image = await imageFromAssetBundle('assets/image.png');

                  doc.addPage(pw.Page(build: (pw.Context context) {
                    return pw.Center(
                      child: pw.Image(image),
                    ); // Center
                  })); //
                },
                child: const Text('Print QR Code'))
          ],
        ));
  }
}
