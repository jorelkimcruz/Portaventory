import 'package:portaventory/helpers/exported_packages.dart';

import '../../entity/item/item.dart';

class QRCodeViewController extends GetxController with StateMixin {
  QRCodeViewController({required this.qrdata, required this.item});

  String qrdata;
  Item item;

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
