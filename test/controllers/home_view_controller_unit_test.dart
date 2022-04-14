import 'dart:io';
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

  StoreRef<String, Map<String, Object?>>? store;
  Database? db;

  BindingsBuilder binding(List<Item> items) {
    return BindingsBuilder(() async {
      // In memory factory for unit test
      var factory = databaseFactoryMemory;
      // Define the store
      // store =
      store = StoreRef<String, Map<String, Object?>>.main();

      // Open the database
      db = await factory.openDatabase('test.db');

      if (items.isNotEmpty) {
        for (var item in items) {
          await store!.add(db!, item.toMap());
        }
      }

      Get.lazyPut<HomeViewController>(
        () => HomeViewController(database: db!, storeRef: store!),
      );
    });
  }

  // test('pre-test sembast initialization', () async {
  //   // In memory factory for unit test
  //   var factory = databaseFactoryMemory;

  //   // Define the store
  //   var store2 = StoreRef<int, Map<String, Object?>>.main();
  //   // Define the record

  //   // Open the database
  //   var db2 = await factory.openDatabase('test.db');

  //   // Write a record

  //   final item = Item();
  //   item.description = 'description1';
  //   item.name = 'name1';
  //   item.type = ItemType.storage;
  //   item.children = [
  //     Item(
  //       id: "01",
  //       name: 'name01',
  //       description: 'description01',
  //       type: ItemType.storage,
  //     ),
  //     Item(
  //       id: "02",
  //       name: 'name02',
  //       description: 'description02',
  //       type: ItemType.storage,
  //     )
  //   ];

  //   await store2.add(db2, item.toMap());

  //   expect(
  //       await store2.find(
  //         db2,
  //       ),
  //       isNotEmpty);
  //   final list = await store2.find(
  //     db2,
  //   );
  //   expect(list.length, 1);
  //   // Close the database
  //   await db2.close();
  // });
  group('Given that db has an empty items', () {
    test('then it should return an empty list', () async {
      expect(Get.isPrepared<HomeViewController>(), false);
      binding([]).builder();

      // await for db to initialize
      await Future.delayed(const Duration(milliseconds: 100));

      /// recover your controller
      final controller = Get.find<HomeViewController>();

      /// check if onInit was called
      expect(controller.initialized, true);

      /// check initial Status
      expect(controller.status.isLoading, true);

      /// await time request
      await Future.delayed(const Duration(milliseconds: 100));

      if (controller.status.isError) {
        expect(controller.state, null);
      }

      expect(controller.items.isEmpty, true);
    });
  });

  group('Given that an item is updated', () {
    test('then it should return an updated item', () async {
      expect(Get.isPrepared<HomeViewController>(), false);
      final item = Item();
      // item.id = "1";
      item.description = 'description1';
      item.name = 'name1';
      item.type = ItemType.storage;
      item.children = [
        Item(
          id: "01",
          name: 'name01',
          description: 'description01',
          type: ItemType.storage,
        ),
        Item(
          id: "02",
          name: 'name02',
          description: 'description02',
          type: ItemType.storage,
        )
      ];
      binding([item]).builder();

      /// await time request
      await Future.delayed(const Duration(milliseconds: 100));

      /// recover your controller
      final controller = Get.find<HomeViewController>();

      /// check if onInit was called
      expect(controller.initialized, true);

      /// check initial Status
      expect(controller.status.isLoading, true);

      /// await time request
      await Future.delayed(const Duration(milliseconds: 100));

      if (controller.status.isError) {
        expect(controller.state, null);
      }

      expect(controller.items.isNotEmpty, true);

      expect(controller.items[0].description, 'description1');

      item.description = 'new descriotopn';
      await store!.record(controller.items[0].id!).put(db!, item.toMap());

      expect(controller.items[0].description, 'new descriotopn');
    });
  });
  group('Given that an item is added', () {
    test('then it should return an updated item', () async {
      expect(Get.isPrepared<HomeViewController>(), false);

      binding([]).builder();

      /// await time request
      await Future.delayed(const Duration(milliseconds: 100));

      /// recover your controller
      final controller = Get.find<HomeViewController>();

      /// check if onInit was called
      expect(controller.initialized, true);

      /// check initial Status
      expect(controller.status.isLoading, true);

      /// await time request
      await Future.delayed(const Duration(milliseconds: 100));

      if (controller.status.isError) {
        expect(controller.state, null);
      }
      print(controller.items);
      expect(controller.items.isEmpty, true);

      final item = Item();
      item.description = 'description1';
      item.name = 'name1';
      item.type = ItemType.storage;
      item.children = [
        Item(
          id: "01",
          name: 'name01',
          description: 'description01',
          type: ItemType.storage,
        ),
        Item(
          id: "02",
          name: 'name02',
          description: 'description02',
          type: ItemType.storage,
        )
      ];

      await store!.add(db!, item.toMap());

      expect(controller.items.isNotEmpty, true);
    });
  });
  // group('Given that db has a single item', () {
  //   test('then it should return one item', () async {
  //     expect(Get.isPrepared<HomeViewController>(), false);

  //     final item = Item();
  //     item.id = "0";
  //     item.description = 'description1';
  //     item.name = 'name1';
  //     item.type = ItemType.storage;
  //     item.children = [
  //       Item(
  //         id: "01",
  //         name: 'name01',
  //         description: 'description01',
  //         type: ItemType.storage,
  //       ),
  //       Item(
  //         id: "02",
  //         name: 'name02',
  //         description: 'description02',
  //         type: ItemType.storage,
  //       )
  //     ];
  //     binding([item]).builder();

  //     // await for db to initialize
  //     await Future.delayed(const Duration(milliseconds: 100));

  //     /// recover your controller
  //     final controller = Get.find<HomeViewController>();

  //     /// check if onInit was called
  //     expect(controller.initialized, true);

  //     /// check initial Status
  //     expect(controller.status.isLoading, true);

  //     /// await time request
  //     await Future.delayed(const Duration(milliseconds: 100));

  //     if (controller.status.isError) {
  //       expect(controller.state, null);
  //     }

  //     expect(controller.items.length, 1);
  //   });
  // });

  // group('Given that db has multiple items', () {
  //   test('then it should return multiple items', () async {
  //     expect(Get.isPrepared<HomeViewController>(), false);

  //     final item = Item();
  //     item.id = "0";
  //     item.description = 'description1';
  //     item.name = 'name1';
  //     item.type = ItemType.storage;
  //     item.children = [
  //       Item(
  //         id: "01",
  //         name: 'name01',
  //         description: 'description01',
  //         type: ItemType.storage,
  //       ),
  //       Item(
  //         id: "02",
  //         name: 'name02',
  //         description: 'description02',
  //         type: ItemType.storage,
  //       )
  //     ];

  //     final item2 = Item();
  //     item2.id = "0";
  //     item2.description = 'description1';
  //     item2.name = 'name1';
  //     item2.type = ItemType.storage;
  //     item2.children = [
  //       Item(
  //         id: "01",
  //         name: 'name01',
  //         description: 'description01',
  //         type: ItemType.storage,
  //       ),
  //       Item(
  //         id: "02",
  //         name: 'name02',
  //         description: 'description02',
  //         type: ItemType.storage,
  //       )
  //     ];
  //     binding([item, item2]).builder();

  //     // await for db to initialize
  //     await Future.delayed(const Duration(milliseconds: 100));

  //     /// recover your controller
  //     final controller = Get.find<HomeViewController>();

  //     /// check if onInit was called
  //     expect(controller.initialized, true);

  //     /// check initial Status
  //     expect(controller.status.isLoading, true);

  //     /// await time request
  //     await Future.delayed(const Duration(milliseconds: 100));

  //     if (controller.status.isError) {
  //       expect(controller.state, null);
  //     }

  //     expect(controller.items.length, 2);
  //   });

  //   group('Given that a user removed an item to db', () {
  //     test('then it should reflect change to list items', () async {
  //       disableSembastCooperator();
  //       expect(Get.isPrepared<HomeViewController>(), false);

  //       final item = Item();
  //       item.id = "1";
  //       item.description = 'description1';
  //       item.name = 'name1';
  //       item.type = ItemType.storage;
  //       item.children = [
  //         Item(
  //           id: "01",
  //           name: 'name01',
  //           description: 'description01',
  //           type: ItemType.storage,
  //         ),
  //         Item(
  //           id: "02",
  //           name: 'name02',
  //           description: 'description02',
  //           type: ItemType.storage,
  //         )
  //       ];

  //       final item2 = Item();
  //       item2.id = "2";
  //       item2.description = 'description11';
  //       item2.name = 'name11';
  //       item2.type = ItemType.storage;
  //       item2.children = [
  //         Item(
  //           id: "01",
  //           name: 'name011',
  //           description: 'description011',
  //           type: ItemType.storage,
  //         ),
  //         Item(
  //           id: "02",
  //           name: 'name012',
  //           description: 'description02',
  //           type: ItemType.storage,
  //         )
  //       ];
  //       binding([item, item2]).builder();

  //       // await for db to initialize
  //       await Future.delayed(const Duration(milliseconds: 100));

  //       /// recover your controller
  //       final controller = Get.find<HomeViewController>();

  //       /// check if onInit was called
  //       expect(controller.initialized, true);

  //       /// check initial Status
  //       expect(controller.status.isLoading, true);

  //       /// await time request
  //       await Future.delayed(const Duration(milliseconds: 100));

  //       if (controller.status.isError) {
  //         expect(controller.state, null);
  //       }

  //       expect(controller.items.length, 2);

  //       final deleted = await controller.removeItem(item);

  //       expect(deleted, 1);
  //       expect(controller.items.length, 1);
  //     });
  //   });
  // });
}
