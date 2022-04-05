import 'package:portaventory/helpers/exported_packages.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScannerViewController extends GetxController with StateMixin {
  ScannerViewController();
  Barcode? result;
  QRViewController? qrController;

  void onQRViewCreated(QRViewController controller) {
    qrController = controller;
    controller.scannedDataStream.listen((scanData) {
      print('===SCANEDDDATA ===> ${scanData.code}');
      result = scanData;
    });
  }
}
