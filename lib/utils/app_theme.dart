import 'package:event/utils/app_colors.dart';
import 'package:event/utils/app_style.dart';
import 'package:flutter/material.dart';

class AppTheme {

  static final ThemeData lightTheme = ThemeData(
    focusColor: AppColors.whiteColor,
    primaryColor: AppColors.primaryLight,
    shadowColor: AppColors.whiteBgColor,
    scaffoldBackgroundColor: AppColors.whiteBgColor,
    textTheme: TextTheme(
      headlineLarge: AppStyle.bold20Black,
      headlineMedium: AppStyle.medium16Primary,
      headlineSmall: AppStyle.medium16White,
      bodyMedium: AppStyle.medium16Black,
    ),
    
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primaryLight,
      
      
      
      
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.primaryLight,
      type: BottomNavigationBarType.fixed,
      unselectedItemColor: AppColors.whiteColor,
      selectedItemColor: AppColors.whiteColor,
      showUnselectedLabels: true,
      selectedLabelStyle: AppStyle.bold12White,
      unselectedLabelStyle: AppStyle.bold12White,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      
      backgroundColor: AppColors.primaryLight,
      shape: StadiumBorder(
        side: BorderSide(
          color: AppColors.whiteColor,
          width: 4,
        ),
      ),
    ),
    
  );

  static final ThemeData darkTheme = ThemeData(
    focusColor: AppColors.primaryLight,
    primaryColor: AppColors.primaryDark,
    shadowColor: AppColors.primaryDark,
    scaffoldBackgroundColor: AppColors.primaryDark,
    textTheme: TextTheme(
      headlineLarge: AppStyle.bold20White,
      headlineMedium: AppStyle.medium16White,
      headlineSmall: AppStyle.medium16White,
      bodyMedium: AppStyle.medium16White,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primaryDark
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.primaryDark,
      type: BottomNavigationBarType.fixed,
      unselectedItemColor: AppColors.whiteColor,
      selectedItemColor: AppColors.whiteColor,
      showUnselectedLabels: true,
      selectedLabelStyle: AppStyle.bold12White,
      unselectedLabelStyle: AppStyle.bold12White,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryDark,
      shape: StadiumBorder(
        side: BorderSide(
          color: AppColors.whiteColor,
          width: 4,
        ),
      ),
    )
  );
  
}