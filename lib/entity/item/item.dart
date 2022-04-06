import 'package:sembast/sembast.dart';

class Item {
  int? id;
  String? type;
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

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      columnName: name,
      columnDescription: description,
      columnType: type,
    };

    if (children != null && children!.isNotEmpty) {
      map[columnChildren] = children!.map((e) => e.toMap()).toList();
    }
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  Item.fromMap(RecordChange<int, Map<String, Object?>> change) {
    final map = change.newSnapshot!.value;
    id = change.ref.key;
    type = map[columnType] as String?;
    name = map[columnName] as String?;
    description = map[columnDescription] as String?;
    if (map[columnChildren] != null) {
      children = (map[columnChildren] as List<dynamic>)
          .map((e) => Item.fromMap(e))
          .toList();
    }
  }
}
