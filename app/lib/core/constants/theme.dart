import 'package:flutter/material.dart';
import 'colors.dart';
import 'sizes.dart';

class AppTheme {
  AppTheme._();

  static ThemeData? theme = ThemeData(
    colorScheme: ColorScheme(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      background: AppColors.scaffoldBg,
      surface: AppColors.scaffoldBg,
      onBackground: AppColors.grayDark.withOpacity(0.05),
      error: AppColors.red,
      onError: AppColors.white,
      onPrimary: AppColors.black,
      onSecondary: AppColors.black,
      onSurface: AppColors.black,
      brightness: Brightness.light,
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 0,
      shadowColor: AppColors.transparent,
      surfaceTintColor: AppColors.transparent,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 8.0,
        shadowColor: AppColors.primary,
        backgroundColor: AppColors.primary,
        disabledBackgroundColor: AppColors.primary.withOpacity(0.4),
        disabledForegroundColor: Colors.grey,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.lg,
          vertical: AppSizes.md + 4,
        ),
        textStyle: const TextStyle(
          fontSize: AppSizes.fontSizeMd,
          fontWeight: FontWeight.bold,
          color: AppColors.white,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
        ),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      prefixIconColor: AppColors.black,
      suffixIconColor: AppColors.black,
      isDense: false,
      // filled: true,
      // fillColor: AppColors.grayLight,
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.secondary,
          width: AppSizes.borderSide,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(AppSizes.borderRadiusMd),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.secondary,
          width: AppSizes.borderSide,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(AppSizes.borderRadiusMd),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.primary,
          width: AppSizes.borderSide * 2,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(AppSizes.borderRadiusMd),
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.red,
          width: AppSizes.borderSide * 2,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(AppSizes.borderRadiusMd),
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.red,
          width: AppSizes.borderSide * 2,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(AppSizes.borderRadiusMd),
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.primary,
          width: AppSizes.borderSide,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(AppSizes.borderRadiusMd),
        ),
      ),
    ),
  );
}
