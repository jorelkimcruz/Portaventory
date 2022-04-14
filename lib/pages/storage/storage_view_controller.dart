import 'package:portaventory/helpers/exported_packages.dart';

import '../../entity/item/item.dart';

class StorageViewController extends GetxController with StateMixin {
  StorageViewController(this.storage, this.database, this.store);

  final Item storage;
  final Database database;
  final StoreRef<String, Map<String, Object?>> store;
  late RxList<Item> items;

  @override
  void onInit() {
    items = (storage.children ?? []).obs;
    store.addOnChangesListener(database, (transaction, changes) async {
      for (var change in changes) {
        if (change.isUpdate) {
          final updateItem = Item.fromMap(
              "${change.ref.key}${items.length + 1}",
              change.newSnapshot!.value);
          items.value = updateItem.children!;
        }
      }
    });

    super.onInit();
  }

  Future<String?> removeItem(Item item) async {
    items.removeWhere((element) => element == item);
    storage.children = items;
    final _ = await store.record(storage.id!).update(database, storage.toMap());
    return item.id;
  }

  List<Item> mapChanges(
      List<RecordChange<String, Map<String, Object?>>> changes) {
    return changes
        .map((e) => Item.fromMap(e.ref.key, e.newSnapshot!.value))
        .toList();
  }
}
