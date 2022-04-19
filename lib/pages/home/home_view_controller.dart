import 'dart:async';
import 'package:portaventory/helpers/exported_packages.dart';
import '../../entity/item/item.dart';

class HomeViewController extends GetxController with StateMixin {
  HomeViewController({required this.storeRef, required this.database});

  StoreRef<String, Map<String, Object?>> storeRef;
  Database database;

  RxList<Item> items = RxList<Item>([]);

  @override
  void onInit() async {
// Track query changes
    storeRef.addOnChangesListener(database, (transaction, changes) async {
      for (var change in changes) {
        if (change.isAdd) {
          items.addAll(mapChanges(changes));
        } else if (change.isUpdate) {
          final item = Item.fromMap(change.ref.key, change.newSnapshot!.value);
          final indexx = items.indexWhere(
              (element) => element.id == null || element.id == item.id);
          items[indexx] = item;
        } else if (change.isDelete) {
          final item = Item.fromMap(change.ref.key, change.oldSnapshot!.value);
          items.removeWhere((element) => element.id == item.id);
        }
      }
    });

    items.value = mapItems(await fetchItems());

    super.onInit();
  }

  @override
  void onClose() {
    storeRef.removeOnChangesListener(database, (transaction, changes) {});
    super.onClose();
  }

  Item findScannedQR(dynamic result) {
    final arArray = result.split("\$");
    final signature = arArray[0].toString().replaceAll('XX', "");
    final id = arArray[1].toString();
    final name = arArray[2];

    return items.firstWhere(
      (element) =>
          signature == portaventory && element.id == id && element.name == name,
      orElse: () => throw 'No Storage Found',
    );
  }

  Future<String?> removeItem(Item item) async {
    return storeRef.record(item.id!).delete(database);
  }

  List<Item> mapChanges(
      List<RecordChange<String, Map<String, Object?>>> changes) {
    return changes
        .map((e) => Item.fromMap(e.ref.key, e.newSnapshot!.value))
        .toList();
  }

  List<Item> mapItems(
      List<RecordSnapshot<String, Map<String, Object?>>> snapshot) {
    return snapshot.isNotEmpty
        ? snapshot.map((e) => Item.fromMap(e.ref.key, e.value)).toList()
        : [];
  }

  Future<List<RecordSnapshot<String, Map<String, Object?>>>>
      fetchItems() async {
    return storeRef.find(database, finder: Finder());
  }

  String uniqueQRData(Item item) {
    return "$portaventory${"XX"}\$${item.id}\$${item.name}";
  }

  List<Item> getAllItems() {
    List<Item> list = [];
    for (var storage in items) {
      for (var item in storage.children!) {
        item.parent = storage;
      }
      list.addAll(storage.children ?? []);
    }
    list.addAll(items);
    return list;
  }
}
