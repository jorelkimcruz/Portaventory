class Item {
  int? id;
  String? type;
  String? name;
  String? description;

  Item();

  static String tableItem = 'item';

  static String columnId = '_id';
  static String columnName = 'name';
  static String columnType = 'type';
  static String columnDescription = 'description';

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      columnName: name,
      columnDescription: description,
      columnType: type,
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  Item.fromMap(Map<String, Object?> map) {
    id = map[columnId] as int?;
    type = map[columnType] as String?;
    name = map[columnName] as String?;
    description = map[columnDescription] as String?;
  }

  static String rawQuery =
      'CREATE TABLE ${Item.tableItem} (${Item.columnId} INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, ${Item.columnName} TEXT, ${Item.columnDescription} TEXT,  ${Item.columnType} TEXT)';
}
