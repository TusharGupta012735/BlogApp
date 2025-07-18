import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AppTheme {
  //adding square bracket to variable in a parameter allows to give it a default value
  static _border([Color color = AppPallete.borderColor]) => OutlineInputBorder(
    borderSide: BorderSide(color: color, width: 2),
    borderRadius: BorderRadius.circular(10),
  );

  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(27),
      enabledBorder: _border(),
      focusedBorder: _border(AppPallete.gradient2),
      errorBorder: _border(AppPallete.errorColor),
      border: _border(),
    ),
    appBarTheme: AppBarTheme(backgroundColor: AppPallete.backgroundColor),
    chipTheme: ChipThemeData(
      backgroundColor: AppPallete.backgroundColor,
      selectedColor: AppPallete.gradient1,
      side: BorderSide.none,
    ),
  );
}
