import 'package:flutter/material.dart';
import '../../helpers/exported_packages.dart';
import 'splashscreen_view_controller.dart';

class SplashscreenView extends GetView<SplashScreenViewsController> {
  const SplashscreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller;
    return const Scaffold(
      body: Center(
        child: Text(
          'PORTAVENTORY',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
