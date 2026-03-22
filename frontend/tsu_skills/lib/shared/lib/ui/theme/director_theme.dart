import 'package:flutter/material.dart';
import 'package:tsu_skills/shared/lib/ui/theme/text_styles.dart';

final directorAppTheme = ThemeData(
  appBarTheme: AppBarTheme(centerTitle: true),
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.orange,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    ),
  ),

  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.orange,
    foregroundColor: Colors.white,
    shape: const CircleBorder(),
  ),

  navigationRailTheme: const NavigationRailThemeData(
    backgroundColor: Color.fromRGBO(255, 152, 0, 1), // Оранжевый
    selectedIconTheme: IconThemeData(color: Colors.white),
    selectedLabelTextStyle: TextStyle(color: Colors.white),
    unselectedIconTheme: IconThemeData(color: Colors.white70),
    unselectedLabelTextStyle: TextStyle(color: Colors.white70),
    minWidth: 80,
  ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: const Color.fromRGBO(255, 152, 0, 1), // Оранжевый
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.grey[200],
    type: BottomNavigationBarType.fixed,
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
    ),
    contentPadding: const EdgeInsets.symmetric(
      vertical: 16.0,
      horizontal: 12.0,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(color: Colors.grey, width: 1.5),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(
        color: const Color.fromRGBO(255, 152, 0, 1),
        width: 1.5,
      ),
    ),
  ),
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
        color: Color(0xFFFF9800), // Оранжевый акцент
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    ),
  ],
);
