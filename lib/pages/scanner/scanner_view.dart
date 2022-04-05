import 'package:flutter/material.dart';
import 'package:portaventory/pages/scanner/scanner_view_controller.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../helpers/exported_packages.dart';

class ScannerView extends GetView<ScannerViewController> {
  const ScannerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
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
        ],
      ),
    );
  }
}
