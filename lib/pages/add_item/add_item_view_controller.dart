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

  void saveItem() async {
    final item = Item();
    item.type = type.value;
    item.name = name.text;
    item.description = description.text;
    try {
      await insert(item);
    } catch (error) {
      rethrow;
    }
  }

  Future<Item> insert(Item item) async {
    item.id = await database.insert(Item.tableItem, item.toMap());
    return item;
  }
}
