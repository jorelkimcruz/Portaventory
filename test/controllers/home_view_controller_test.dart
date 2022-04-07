import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  setUpAll(() async {
    HttpOverrides.global = null;
    TestWidgetsFlutterBinding.ensureInitialized();
  });
  setUp(() async {
    Get.reset();
  });
}
