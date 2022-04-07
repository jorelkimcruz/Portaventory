import 'package:get/get.dart';
import 'package:portaventory/helpers/exported_packages.dart';
import 'package:portaventory/pages/add_item/add_item_view.dart';
import 'package:portaventory/pages/add_item/add_item_view_binding.dart';
import 'package:portaventory/pages/home/home_view_binding.dart';
import 'package:portaventory/pages/scanner/scanner_view.dart';
import 'package:portaventory/pages/scanner/scanner_view_binding.dart';
import 'package:portaventory/pages/splashscreen/splashscreen_view.dart';
import 'package:portaventory/pages/splashscreen/splashscreen_view_binding.dart';
import '../home/home_view.dart';
part 'app_routes.dart';

// ignore: avoid_classes_with_only_static_members
class AppPages {
  static const initial = Routes.splashscreen;
  static final routes = [
    GetPage(
      name: Routes.splashscreen,
      binding: SplashScreenViewBinding(),
      page: () => const SplashscreenView(),
      transition: Transition.fade,
    ),
    GetPage(
      name: Routes.home,
      binding: HomeViewBinding(),
      page: () => const HomeView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Routes.scanner,
      binding: ScannerViewBinding(),
      page: () => const ScannerView(),
    ),
    GetPage(
      name: Routes.addItem,
      binding: AddItemViewBinding(),
      page: () => const AddItemView(),
    ),
  ];
}
