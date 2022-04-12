import 'package:portaventory/helpers/exported_packages.dart';

class DataSource {
  DataSource(this.database, this.store);

  final Database database;
  final StoreRef store;
}
