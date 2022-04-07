import 'package:get/get.dart';
import 'package:portaventory/pages/splashscreen/splashscreen_view_controller.dart';

class SplashScreenViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashScreenViewsController>(
      () => SplashScreenViewsController(),
    );
  }
}
