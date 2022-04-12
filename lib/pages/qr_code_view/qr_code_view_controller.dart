import 'package:portaventory/helpers/exported_packages.dart';

class QRCodeViewController extends GetxController with StateMixin {
  QRCodeViewController(this.qrdata);

  String qrdata;

  @override
  void onInit() async {
    super.onInit();
  }

  void print() async {}

  @override
  void onClose() {
    super.onClose();
  }
}
