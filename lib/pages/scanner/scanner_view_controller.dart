import 'package:portaventory/helpers/exported_packages.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScannerViewController extends GetxController with StateMixin {
  ScannerViewController();

  Barcode? result;
  QRViewController? qrController;

  void onQRViewCreated(QRViewController controller) {
    qrController = controller;
    controller.scannedDataStream.listen((scanData) async {
      print('======+> ${scanData.code}');

      result = scanData;
      final scannedcode = result!.code!;
      if (scannedcode.contains(portaventory)) {
        Get.back(result: result!.code);
      }
    }).onError((error) {
      print('==>>>ERROR $error');
    });
  }
}
