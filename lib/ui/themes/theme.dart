import 'package:flutter/material.dart';

class ThemeClass {
  static ThemeData darkTheme = ThemeData(
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 250, 253, 253)),
              backgroundColor: MaterialStateProperty.all(
                  const Color(0xFF2EAEBE).withOpacity(0.6)))),
      progressIndicatorTheme: ProgressIndicatorThemeData(
          circularTrackColor: const Color(0xFF2EAEBE).withOpacity(0.3),
          color: const Color(0xFF2EAEBE)),
      primaryColor: const Color(0xFF2EAEBE),
      fontFamily: 'Raleway',
      textTheme: _texTheme,
      canvasColor: const Color.fromRGBO(31, 34, 45, 0.8),
      scaffoldBackgroundColor: const Color(0xFF272B36),
      colorScheme: const ColorScheme.dark(),
      inputDecorationTheme: const InputDecorationTheme(
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF2EAEBE))),
      ),
      iconTheme: const IconThemeData(color: Color(0xFF2EAEBE)),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Color(0xFF2EAEBE),
      ),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
        foregroundColor: const Color(0xFF2EAEBE),
      )),
      iconButtonTheme: IconButtonThemeData(
          style: IconButton.styleFrom(
              backgroundColor: Colors.transparent,
              foregroundColor: const Color(0xFF2EAEBE),
              iconSize: 45

              // splashFactory:

              )),
      // floatingActionButtonTheme: FloatingActionButtonThemeData(
      //   backgroundColor: const Color(0xFF272B36)
      //   ),

      appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
          backgroundColor: Color(0xFF272B36),
          shadowColor: Colors.transparent),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          selectedItemColor: Color(0xFF2EAEBE),
          unselectedItemColor: Color(0xFF2D3240),
          selectedLabelStyle: TextStyle(fontSize: 12)),
      navigationBarTheme: const NavigationBarThemeData(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ));
}

const _texTheme = TextTheme(
  titleLarge: TextStyle(
    fontSize: 77,
    fontWeight: FontWeight.w700,
  ),
  titleMedium: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w500,
  ),
  titleSmall: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
  ),
  labelMedium: TextStyle(
      fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xFF90939B)),
  bodyLarge: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
  ),
  bodyMedium: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.2,
  ),
);
