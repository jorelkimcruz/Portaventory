import 'package:portaventory/helpers/exported_packages.dart';
import 'package:portaventory/pages/qr_code_view/qr_code_view_controller.dart';

import '../../entity/item/item.dart';

class QRCodeViewBinding extends Bindings {
  @override
  void dependencies() async {
    final arguments = Get.arguments as QRCodeViewArguments;
    Get.lazyPut<QRCodeViewController>(
      () => QRCodeViewController(
        qrdata: arguments.qrdata,
        item: arguments.item,
      ),
    );
  }
}

class QRCodeViewArguments {
  QRCodeViewArguments({required this.qrdata, required this.item});
  final String qrdata;
  final Item item;
}
