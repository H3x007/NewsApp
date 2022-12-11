import 'package:flutter/material.dart';
import 'package:news_app/styles/colors.dart';

ThemeData lightTheme() => ThemeData(
      primarySwatch: Colors.purple,
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF6157D4),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.grey[200],
        selectedItemColor: Color(0xFF8B4D93),
        unselectedItemColor: Color(0xFF5F7187),
        type: BottomNavigationBarType.fixed,
      ),
    );

ThemeData darkTheme() => ThemeData(
      primarySwatch: Colors.purple,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Color(0xFF121212),
    );
