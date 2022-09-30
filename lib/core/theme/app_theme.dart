import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:try_me/meta/utils/constants.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Montserrat',
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: const MaterialStatePropertyAll(kprimaryColor),
        foregroundColor: const MaterialStatePropertyAll(Colors.white),
        padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 80, vertical: 10)),
        textStyle: MaterialStatePropertyAll(TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
        )),
        elevation: const MaterialStatePropertyAll(0),
        shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: kprimaryColor),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 30.sp,
        fontWeight: FontWeight.w900,
        color: ksecondaryColor,
        fontFamily: "Futura",
      ),
      titleMedium: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
        fontFamily: "Futura",
      ),
      titleSmall: TextStyle(
        fontSize: 15.sp,
        fontWeight: FontWeight.bold,
        fontFamily: "Futura",
      ),
      labelLarge: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.bold,
      ),
      labelMedium: TextStyle(
        fontSize: 10.sp,
        fontWeight: FontWeight.bold,
      ),
      labelSmall: TextStyle(
        fontSize: 8.sp,
        fontWeight: FontWeight.bold,
        letterSpacing: 1,
      ),
    ),
  );
}
