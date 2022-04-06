import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:portaventory/helpers/exported_packages.dart';

import '../../entity/item/item.dart';

class HomeViewController extends GetxController with StateMixin {
  HomeViewController();

  StoreRef<int, Map<String, Object?>>? _storeRef;
  Database? _database;

  RxList<Item> items = RxList<Item>([]);

  Database get database => _database!;

  @override
  void onInit() async {
// File path to a file in the current directory
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    String dbPath = join(appDocPath, 'ventport.db');
    DatabaseFactory dbFactory = databaseFactoryIo;

// We use the database factory to open the database
    _database = await dbFactory.openDatabase(dbPath);
    _storeRef = intMapStoreFactory.store();

    items.value = await getItems();

    super.onInit();
  }

  Future<List<Item>> getItems() async {
    var itemsSnap = await _storeRef!.find(_database!, finder: Finder());
    return itemsSnap.isNotEmpty
        ? itemsSnap.map((e) => Item.fromMap(e.value)).toList()
        : [];
  }
}
