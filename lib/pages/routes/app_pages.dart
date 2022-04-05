import 'package:get/get.dart';
import 'package:portaventory/pages/home/home_view_binding.dart';
import 'package:portaventory/pages/scanner/scanner_view.dart';
import 'package:portaventory/pages/scanner/scanner_view_binding.dart';
import '../home/home_view.dart';
part 'app_routes.dart';

// ignore: avoid_classes_with_only_static_members
class AppPages {
  static const initial = Routes.home;
  static final routes = [
    GetPage(
      name: Routes.home,
      binding: HomeViewBinding(),
      page: () => const HomeView(),
    ),
    GetPage(
      name: Routes.scanner,
      binding: ScannerViewBinding(),
      page: () => const ScannerView(),
    ),
  ];
}
