import 'package:flutter/material.dart';
import 'package:portaventory/entity/item/item.dart';
import 'package:portaventory/helpers/exported_packages.dart';

class AddItemViewController extends GetxController with StateMixin {
  AddItemViewController({required this.database, this.storage});

  final Database database;
  final Item? storage;

  final RxString type = ItemType.values.first.name.obs;
  final TextEditingController name = TextEditingController();
  final TextEditingController description = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> saveItem() async {
    final item = Item();
    item.type = type.value.toLowerCase() == ItemType.item.name
        ? ItemType.item
        : ItemType.storage;

    item.name = name.text;
    item.description = description.text;

    try {
      if (storage == null) {
        await insert(item);
      } else {
        if (storage!.children == null) {
          storage!.children = [];
        }
        storage!.children!.add(item);
        await updateExisting(item);
      }

      return;
    } catch (error) {
      print('ERROR $error');
      rethrow;
    }
  }

  Future<Item> insert(Item item) async {
    // Store some objects
    final _storeRef = stringMapStoreFactory.store();
    final count = await _storeRef.count(database,
        filter: Filter.equals(Item.columnName, item.name));
    if (count == 0) {
      final sdsd = await _storeRef.add(database, item.toMap());
      print("Key: $sdsd Type: ${sdsd.runtimeType}");
      return item;
    } else {
      throw 'Name already exists!';
    }
  }

  Future<Item> updateExisting(Item item) async {
    // Store some objects
    final _storeRef = stringMapStoreFactory.store();
    final _ =
        await _storeRef.record(storage!.id!).update(database, storage!.toMap());
    return item;
  }
}
