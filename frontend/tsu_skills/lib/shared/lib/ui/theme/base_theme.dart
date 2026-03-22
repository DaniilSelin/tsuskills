import 'package:flutter/material.dart';
import 'package:tsu_skills/shared/lib/ui/theme/input_decoration.dart';
import 'package:tsu_skills/shared/lib/ui/theme/text_styles.dart';

final baseAppTheme = ThemeData(
  appBarTheme: AppBarTheme(centerTitle: true),
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    ),
  ),

  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.blue,
    foregroundColor: Colors.white,
    shape: const CircleBorder(),
  ),

  navigationRailTheme: const NavigationRailThemeData(
    backgroundColor: Color.fromRGBO(0, 150, 255, 1),
    selectedIconTheme: IconThemeData(color: Color.fromRGBO(0, 150, 255, 1)),
    selectedLabelTextStyle: TextStyle(color: Colors.white),
    unselectedIconTheme: IconThemeData(color: Colors.white),
    unselectedLabelTextStyle: TextStyle(color: Colors.white),

    minWidth: 80,
  ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: const Color.fromRGBO(0, 150, 255, 1),
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.grey,
    type: BottomNavigationBarType.fixed,
  ),

  inputDecorationTheme: inputDecoration,
  extensions: [
    AppTextStylesExtension(
      heading1: TextStyle(
        color: Color(0xFF333333),
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      heading2: TextStyle(
        color: Color(0xFF666666),
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      bodyText: TextStyle(color: Color(0xFF333333), fontSize: 16, height: 1.5),
      secondaryText: TextStyle(color: Color(0xFF666666), fontSize: 14),
      hintText: TextStyle(
        color: Color(0xFF999999),
        fontSize: 14,
        fontStyle: FontStyle.italic,
      ),
      accentText: TextStyle(
        color: Color(0xFF007BFF),
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    ),
  ],
);
