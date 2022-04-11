import 'package:flutter_test/flutter_test.dart';
import 'package:portaventory/entity/item/item.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Given that an item is mapped to json', () {
    group('and maps to model', () {
      test('then it should serialize json to model', () async {
        final item = Item();
        item.id = 0;
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
        final map = item.toMap();
        expect(map['name'], 'name1');
        expect(map['description'], 'description1');
        expect(map['type'], 'storage');
        expect(map['_id'], 0);
        expect((map['children'] as List).length, 2);
        expect((map['children'] as List)[0]['name'], 'name01');
        expect((map['children'] as List)[0]['description'], 'description01');
        expect((map['children'] as List)[1]['name'], 'name02');
        expect((map['children'] as List)[1]['description'], 'description02');

        final mappedItem = Item.fromMap(0, map);
        expect(mappedItem.id, 0);
        expect(mappedItem.name, 'name1');
        expect(mappedItem.type, ItemType.storage);
      });
    });
  });

  group('Given that an with non existing type item is mapped to json', () {
    group('and maps to model', () {
      test('then it should serialize json to model', () async {
        final mappedItem = Item.fromMap(0, {
          Item.columnId: 0,
          Item.columnDescription: 'description',
          Item.columnName: 'name1',
          Item.columnType: 'itemss'
        });
        expect(mappedItem.id, 0);
        expect(mappedItem.name, 'name1');
        expect(mappedItem.description, 'description');
        expect(mappedItem.type, ItemType.item);
      });
    });
  });
}
