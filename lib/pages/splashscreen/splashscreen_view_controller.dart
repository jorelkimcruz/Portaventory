import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:portaventory/helpers/exported_packages.dart';
import 'package:portaventory/pages/home/home_view_binding.dart';

import '../routes/app_pages.dart';

class SplashScreenViewsController extends GetxController with StateMixin {
  SplashScreenViewsController();

  @override
  Future<void> onInit() async {
    // File path to a file in the current directory
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    String dbPath = join(appDocPath, 'ventport.db');
    DatabaseFactory dbFactory = databaseFactoryIo;

    final database = await dbFactory.openDatabase(dbPath);
    final storeRef = intMapStoreFactory.store();
    Future.delayed(const Duration(milliseconds: 1000), () {
      Get.offAndToNamed(Routes.home,
          arguments: HomeViewBindingArguments(database, storeRef));
    });
    super.onInit();
  }
}
