import 'package:get/get.dart';
import 'package:portaventory/entity/item/item.dart';
import 'package:sembast/sembast.dart';
// import 'package:sqflite/sqflite.dart';
import 'add_item_view_controller.dart';

class AddItemViewBinding extends Bindings {
  @override
  void dependencies() {
    final Database database = (Get.arguments as AddItemArguments).database;
    final Item? storage = (Get.arguments as AddItemArguments).storage;
    Get.lazyPut<AddItemViewController>(
      () => AddItemViewController(database: database, storage: storage),
    );
  }
}

class AddItemArguments {
  AddItemArguments({required this.database, this.storage});

  final Database database;
  final Item? storage;
}
