import 'package:flutter/material.dart';

EdgeInsetsGeometry defaultPadding = const EdgeInsets.all(16.0);
EdgeInsetsGeometry smallPadding = const EdgeInsets.all(8.0);
final Map<int, Color> _color = {
  50: const Color.fromRGBO(79, 79, 79, .1),
  100: const Color.fromRGBO(79, 79, 79, .2),
  200: const Color.fromRGBO(79, 79, 79, .3),
  300: const Color.fromRGBO(79, 79, 79, .4),
  400: const Color.fromRGBO(79, 79, 79, .5),
  500: const Color.fromRGBO(79, 79, 79, .6),
  600: const Color.fromRGBO(79, 79, 79, .7),
  700: const Color.fromRGBO(79, 79, 79, .8),
  800: const Color.fromRGBO(79, 79, 79, .9),
  900: const Color.fromRGBO(79, 79, 79, 1),
};
ThemeData get lightTheme {
  return ThemeData(
    brightness: Brightness.light,
    primarySwatch: MaterialColor(0xFF4C4C4C, _color),
    // textButtonTheme: TextButtonThemeData(
    //   style: ButtonStyle(backgroundColor:
    //       MaterialStateProperty.resolveWith<Color?>(
    //           (Set<MaterialState> states) {
    //     return ColorName.grey;
    //   }), foregroundColor: MaterialStateProperty.resolveWith<Color?>(
    //       (Set<MaterialState> states) {
    //     return Colors.white;
    //   })),
    // ),
    // textTheme: const TextTheme(
    //   subtitle1: TextStyle(
    //     color: ColorName.orange,
    //   ),
    // ),
    textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.black),
    // toggleableActiveColor: ColorName.orange,
  );
}

ThemeData get darkTheme {
  return ThemeData(
    brightness: Brightness.dark,
    primarySwatch: MaterialColor(0xFF4C4C4C, _color),
    // textTheme: const TextTheme(
    //   subtitle1: TextStyle(
    //     color: ColorName.orange,
    //   ),
    // ),
    // textButtonTheme: TextButtonThemeData(
    //   style: ButtonStyle(backgroundColor:
    //       MaterialStateProperty.resolveWith<Color?>(
    //           (Set<MaterialState> states) {
    //     return ColorName.lightGrey;
    //   }), foregroundColor: MaterialStateProperty.resolveWith<Color?>(
    //       (Set<MaterialState> states) {
    //     return Colors.white;
    //   })),
    // ),
    // toggleableActiveColor: ColorName.orange,
    textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.white),
    // dividerTheme: const DividerThemeData(color: ColorName.grey)
    // appBarTheme: const AppBarTheme(
    //     brightness: Brightness.dark, backgroundColor: Colors.black),
    // iconTheme: const IconThemeData(color: Colors.white),
    // accentIconTheme: const IconThemeData(color: Colors.white),

    // /// Menu Icon
    // primaryIconTheme: const IconThemeData(color: Colors.white),
    // primaryColor: ColorName.grey,
    // scaffoldBackgroundColor: Colors.black,
    // colorScheme: ThemeData().colorScheme.copyWith(primary: ColorName.grey),
    // accentColor: ColorName.grey,
    // buttonTheme: ButtonThemeData(
    //   shape:
    //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
    //   buttonColor: ColorName.grey,
    // ),
    // // hintColor: Colors.grey,
    // textSelectionTheme:
    //     const TextSelectionThemeData(cursorColor: Colors.grey),
    // inputDecorationTheme: const InputDecorationTheme(
    //   labelStyle: TextStyle(color: ColorName.lightGrey),
    // ),
    // highlightColor: ColorName.lightGrey,
    // textButtonTheme: TextButtonThemeData(
    //   style: TextButton.styleFrom(
    //     primary: Colors.white,
    //     backgroundColor: ColorName.lightGrey,
    //   ),
    // ),
    // textTheme: const TextTheme(
    //     bodyText1: TextStyle(color: ColorName.lightGrey),
    //     bodyText2: TextStyle(color: ColorName.lightGrey),
    //     caption: TextStyle(color: ColorName.lightGrey),
    //     headline1: TextStyle(color: ColorName.lightGrey),
    //     headline2: TextStyle(color: ColorName.lightGrey),
    //     headline3: TextStyle(color: ColorName.lightGrey),
    //     headline4: TextStyle(color: ColorName.lightGrey),
    //     headline5: TextStyle(color: ColorName.lightGrey),
    //     headline6: TextStyle(color: ColorName.lightGrey),
    //     subtitle2: TextStyle(color: ColorName.lightGrey),
    //     subtitle1: TextStyle(color: ColorName.lightGrey),
    //     overline: TextStyle(color: ColorName.lightGrey))
  );
}
