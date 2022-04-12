import 'package:get/get.dart';
import 'package:portaventory/pages/storage/storage_view_controller.dart';
import 'package:sembast/sembast.dart';

import '../../entity/item/item.dart';

class StorageViewBinding extends Bindings {
  @override
  void dependencies() {
    final arg = Get.arguments as StorageViewArguments;
    Get.lazyPut<StorageViewController>(
      () => StorageViewController(arg.storage, arg.database, arg.store),
    );
  }
}

class StorageViewArguments {
  StorageViewArguments(this.storage, this.database, this.store);
  final Item storage;
  final Database database;
  final StoreRef<int, Map<String, Object?>> store;
}
