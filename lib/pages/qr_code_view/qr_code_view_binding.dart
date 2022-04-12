import 'package:portaventory/helpers/exported_packages.dart';
import 'package:portaventory/pages/qr_code_view/qr_code_view_controller.dart';

class QRCodeViewBinding extends Bindings {
  @override
  void dependencies() async {
    final arguments = Get.arguments as QRCodeViewArguments;
    Get.lazyPut<QRCodeViewController>(
      () => QRCodeViewController(arguments.data),
    );
  }
}

class QRCodeViewArguments {
  QRCodeViewArguments(this.data);
  final String data;
}
