import 'package:flutter/material.dart';
import 'package:portaventory/pages/home/home_view_controller.dart';
import 'package:portaventory/pages/routes/app_pages.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../helpers/exported_packages.dart';

class HomeView extends GetView<HomeViewController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          QrImage(
            data: 'This is a simple QR code',
            version: QrVersions.auto,
            size: 320,
            gapless: false,
          ),
          TextButton(
            onPressed: () {
              Get.toNamed(Routes.scanner);
            },
            child: Text('SCAN QR CODE'),
          ),
        ],
      ),
    );
  }
}
