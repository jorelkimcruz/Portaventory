import 'package:portaventory/helpers/exported_packages.dart';

import '../../entity/item/item.dart';

class HomeViewController extends GetxController with StateMixin {
  HomeViewController();

  Database? _database;

  RxList<Item> items = RxList<Item>([]);

  Database get database => _database!;

  @override
  void onInit() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');

    // open the database
    _database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
        Item.rawQuery,
      );
    });

    items.value = await getItems();

    super.onInit();
  }

  Future<List<Item>> getItems() async {
    List<Map<String, Object?>> list = await _database!.query(Item.tableItem);
    return list.isNotEmpty ? list.map((e) => Item.fromMap(e)).toList() : [];
  }
}
