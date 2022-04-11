import 'package:flutter/material.dart';
import 'package:portaventory/entity/item/item.dart';
import 'package:portaventory/helpers/exported_packages.dart';

class AddItemViewController extends GetxController with StateMixin {
  AddItemViewController({required this.database});

  final Database database;

  final RxString type = 'Item'.obs;
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
      await insert(item);
      return;
    } catch (error) {
      print('ERROR $error');
      rethrow;
    }
  }

  Future<Item> insert(Item item) async {
    // Store some objects
    final _storeRef = intMapStoreFactory.store();
    final count = await _storeRef.count(database,
        filter: Filter.equals(Item.columnName, item.name));
    if (count == 0) {
      await _storeRef.add(database, item.toMap());
      return item;
    } else {
      throw 'Name already exists!';
    }
  }
}
