import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:portaventory/pages/scanner/scanner_view_controller.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../helpers/exported_packages.dart';

class ScannerView extends GetView<ScannerViewController> {
  const ScannerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: GlobalKey(debugLabel: 'QR'),
              onQRViewCreated: (qrController) =>
                  controller.onQRViewCreated(qrController),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: (controller.result != null)
                  ? Text(
                      'Barcode Type: ${describeEnum(controller.result!.format)}   Data: ${controller.result!.code}')
                  : Text('Scan a code'),
            ),
          )
        ],
      ),
    );
  }
}
