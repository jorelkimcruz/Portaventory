import 'package:get/get.dart';
import 'package:sembast/sembast.dart';
// import 'package:sqflite/sqflite.dart';
import 'add_item_view_controller.dart';

class AddItemViewBinding extends Bindings {
  @override
  void dependencies() {
    final Database database = (Get.arguments as AddItemArguments).database;
    Get.lazyPut<AddItemViewController>(
      () => AddItemViewController(database: database),
    );
  }
}

class AddItemArguments {
  AddItemArguments({required this.database});

  final Database database;
}
