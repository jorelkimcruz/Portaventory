import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:portaventory/pages/routes/app_pages.dart';
import 'helpers/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      // translations: TranslationService(),
      // locale: locale,
      locale: Get.deviceLocale,
      builder: EasyLoading.init(builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child ?? const SizedBox(),
        );
      }),
      routingCallback: (routing) async {},
      theme: lightTheme,
      darkTheme: darkTheme,
    );
  }
}
