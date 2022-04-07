import 'package:portaventory/helpers/exported_packages.dart';
import 'package:portaventory/pages/home/home_view_controller.dart';

class HomeViewBinding extends Bindings {
  @override
  void dependencies() async {
    final arguments = Get.arguments as HomeViewBindingArguments;
    Get.lazyPut<HomeViewController>(
      () => HomeViewController(
          database: arguments.database, storeRef: arguments.storeRef),
    );
  }
}

class HomeViewBindingArguments {
  HomeViewBindingArguments(this.database, this.storeRef);

  final Database database;
  final StoreRef<int, Map<String, Object?>> storeRef;
}
