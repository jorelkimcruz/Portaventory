import 'dart:io';
import 'package:portaventory/pages/add_item/add_item_view_controller.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_memory.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:portaventory/pages/home/home_view_controller.dart';
import 'package:portaventory/entity/item/item.dart';

void main() {
  setUpAll(() async {
    HttpOverrides.global = null;
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  setUp(() async {
    Get.reset();
  });

  StoreRef<int, Map<String, Object?>>? store;
  Database? db;

  BindingsBuilder binding(List<Item> items) {
    return BindingsBuilder(() async {
      // In memory factory for unit test
      var factory = newDatabaseFactoryMemory();
      // Define the store
      // store = StoreRef<int, Map<String, Object?>>.main();
      store = intMapStoreFactory.store();

      // Open the database
      db = await factory.openDatabase('test.db');

      if (items.isNotEmpty) {
        for (var item in items) {
          await store!.add(db!, item.toMap());
        }
      }

      Get.lazyPut<AddItemViewController>(
        () => AddItemViewController(database: db!),
      );
    });
  }

  group('Given that a user save an item', () {
    test('then it should save to db', () async {
      expect(Get.isPrepared<HomeViewController>(), false);
      binding([]).builder();

      // await for db to initialize
      await Future.delayed(const Duration(milliseconds: 100));

      /// recover your controller
      final controller = Get.find<AddItemViewController>();

      /// check if onInit was called
      expect(controller.initialized, true);

      /// check initial Status
      expect(controller.status.isLoading, true);

      /// await time request
      await Future.delayed(const Duration(milliseconds: 100));

      if (controller.status.isError) {
        expect(controller.state, null);
      }
      final records = await store!.find(
        db!,
      );
      expect(records, isEmpty);

      controller.name.text = 'name';
      controller.description.text = 'description';
      controller.type.value = 'item';

      await controller.saveItem();

      final updatedRecords = await store!.find(
        db!,
      );

      expect(updatedRecords, isNotEmpty);
    });
  });

  group('Given that a user save an existing item', () {
    test('then it should save to db', () async {
      expect(Get.isPrepared<HomeViewController>(), false);
      final item = Item();
      item.id = 1;
      item.description = 'description1';
      item.name = 'name1';
      item.type = ItemType.storage;
      item.children = [
        Item(
          id: 01,
          name: 'name01',
          description: 'description01',
          type: ItemType.storage,
        ),
        Item(
          id: 02,
          name: 'name02',
          description: 'description02',
          type: ItemType.storage,
        )
      ];
      binding([item]).builder();

      // await for db to initialize
      await Future.delayed(const Duration(milliseconds: 100));

      /// recover your controller
      final controller = Get.find<AddItemViewController>();

      /// check if onInit was called
      expect(controller.initialized, true);

      /// check initial Status
      expect(controller.status.isLoading, true);

      /// await time request
      await Future.delayed(const Duration(milliseconds: 100));

      if (controller.status.isError) {
        expect(controller.state, null);
      }
      final records = await store!.find(
        db!,
      );
      expect(records, isNotEmpty);

      controller.name.text = 'name1';
      controller.description.text = 'description1';
      controller.type.value = 'item';

      expect(() async => await controller.saveItem(), throwsA(isA<String>()));
    });
  });
  group('Given that a user insert an item', () {
    test('then it should add item to db', () async {
      expect(Get.isPrepared<HomeViewController>(), false);
      binding([]).builder();

      // await for db to initialize
      await Future.delayed(const Duration(milliseconds: 100));

      /// recover your controller
      final controller = Get.find<AddItemViewController>();

      /// check if onInit was called
      expect(controller.initialized, true);

      /// check initial Status
      expect(controller.status.isLoading, true);

      /// await time request
      await Future.delayed(const Duration(milliseconds: 100));

      if (controller.status.isError) {
        expect(controller.state, null);
      }
      final records = await store!.find(
        db!,
      );
      expect(records, isEmpty);

      final item = Item();
      item.id = 1;
      item.description = 'description1';
      item.name = 'name1';
      item.type = ItemType.storage;
      item.children = [
        Item(
          id: 01,
          name: 'name01',
          description: 'description01',
          type: ItemType.storage,
        ),
        Item(
          id: 02,
          name: 'name02',
          description: 'description02',
          type: ItemType.storage,
        )
      ];
      await controller.insert(item);

      final updatedRecords = await store!.find(
        db!,
      );

      expect(updatedRecords, isNotEmpty);
    });
  });
}
