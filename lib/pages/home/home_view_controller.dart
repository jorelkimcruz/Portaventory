import 'dart:async';
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
  StreamSubscription<List<RecordSnapshot<int, Map<String, Object?>>>>?
      _subscription;
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

// Track query changes
    _storeRef!.addOnChangesListener(_database!, (transaction, changes) async {
      for (var change in changes) {
        final item = Item.fromMap(change);
        if (change.isAdd) {
          items.addAll(mapChanges(changes));
        } else if (change.isUpdate) {
          final indexx = items.indexWhere(
              (element) => element.id == null || element.id == item.id);
          items[indexx] = item;
        } else if (change.isDelete) {
          removeItem(item);
        }
      }
    });

    items.value = mapItems(await fetchItems());

    super.onInit();
  }

  @override
  void onClose() {
    unawaited(_subscription?.cancel());
    super.onClose();
  }

  void removeItem(Item item) async {
    await _storeRef!.record(item.id!).delete(_database!);
  }

  List<Item> mapChanges<T>(changes) {
    return changes.map((e) => Item.fromMap(e)).toList();
  }

  List<Item> mapItems(
      List<RecordSnapshot<int, Map<String, Object?>>> snapshot) {
    return snapshot.isNotEmpty
        ? snapshot.map((e) => Item.fromMap(e)).toList()
        : [];
  }

  Future<List<RecordSnapshot<int, Map<String, Object?>>>> fetchItems() async {
    return _storeRef!.find(_database!, finder: Finder());
  }
}
