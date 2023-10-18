import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_fonts.dart';


class AppThemes {

  static ThemeData getTheme() {
    return ThemeData(
        primaryColor: AppColors.primaryColor,
        scaffoldBackgroundColor: AppColors.scaffoldDarkBackground,
        shadowColor: AppColors.primaryColor,
        iconTheme: const IconThemeData(color: AppColors.primaryColor),
        splashColor: AppColors.splashColor,
        fontFamily: AppFonts.fontFamily,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.scaffoldDarkBackground,
          elevation: 3,
          centerTitle: true,
        ),
        textTheme: TextTheme(
          titleLarge: AppFonts.getBoldStyle(color: Colors.white),
          titleMedium: AppFonts.getMediumStyle(size: AppFonts.mediumFontSize, color: Colors.blueGrey[100]!),
          bodyMedium: AppFonts.getRegularStyle(size: AppFonts.smallFontSize, color: Colors.white),
          bodySmall: AppFonts.getRegularStyle(color: Colors.blueGrey[300]!, size: AppFonts.tinyFontSize),
          labelMedium: AppFonts.getRegularStyle(size: AppFonts.tinyFontSize, color: Colors.blueGrey[300]!),
          labelLarge: AppFonts.getMediumStyle(size: AppFonts.smallFontSize, color: Colors.white),
        ),
        inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.blueGrey[300]?.withOpacity(0.9),
            contentPadding: const EdgeInsets.all(5),
            hintStyle: AppFonts.getRegularStyle(color: Colors.blueGrey[900]!),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.transparent, width: 2.0),
            ),
            border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(20)),
            prefixIconColor: Colors.blueGrey[900]!
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: AppColors.scaffoldDarkBackground,
            selectedItemColor: AppColors.primaryColor,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            elevation: 20,
            unselectedItemColor: Colors.blueGrey[300]!
        ),
    );
  }


}