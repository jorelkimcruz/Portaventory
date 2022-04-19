import 'package:sembast/sembast.dart';

class Item {
  /// ID value will always come from sembast storage
  ///
  String? id;
  Item? parent;

  ItemType? type;
  String? name;
  String? description;
  List<Item>? children;

  Item({
    this.id,
    this.type,
    this.name,
    this.description,
    this.children,
  });

  static String tableItem = 'item';

  static String columnId = '_id';
  static String columnName = 'name';
  static String columnType = 'type';
  static String columnDescription = 'description';
  static String columnChildren = 'children';
  static String columnParent = 'parent';

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      columnName: name,
      columnDescription: description,
      columnType: type!.name,
    };

    if (children != null && children!.isNotEmpty) {
      map[columnChildren] = children!.map((e) => e.toMap()).toList();
    }
    if (id != null) {
      map[columnId] = id;
    }

    // if (parent != null) {
    //   map[columnParent] = parent!.toMap();
    // }
    return map;
  }

  Item.fromMap(String key, Map<String, Object?> change) {
    final map = change;
    id = key;
    type = ItemType.values.firstWhere(
        (element) => element.name == map[columnType],
        orElse: () => ItemType.item);
    name = map[columnName] as String?;

    description = map[columnDescription] as String?;
    if (map[columnChildren] != null) {
      children = (map[columnChildren] as List<dynamic>)
          .map((e) => Item.fromMap(key, e))
          .toList();
    }
  }

  List<Item> mapChanges(
      List<RecordChange<String, Map<String, Object?>>> changes) {
    return changes
        .map((e) => Item.fromMap(e.ref.key, e.newSnapshot!.value))
        .toList();
  }
}

enum ItemType {
  storage,
  item,
}
