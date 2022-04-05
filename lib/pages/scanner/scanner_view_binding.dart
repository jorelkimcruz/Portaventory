import 'package:get/get.dart';
import 'package:portaventory/pages/scanner/scanner_view_controller.dart';

class ScannerViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScannerViewController>(
      () => ScannerViewController(),
    );
  }
}
