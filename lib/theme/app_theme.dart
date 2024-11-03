import 'package:flutter/material.dart';
import 'app_colors.dart';


class AppThemes {
  // static final ThemeData appThemeData = ThemeData(
  //   primaryColor: AppColors.botThemeColor,
  // );

  static final lightTheme = ThemeData(
      primaryColor: AppColors.theme,
      brightness: Brightness.light,
      shadowColor: AppColors.black,
      primaryColorLight: AppColors.white,
      primaryColorDark: AppColors.theme,
      dividerColor: AppColors.textfieldBorder,
      hintColor: AppColors.grey,
      cardColor: AppColors.botMessageBG,
      canvasColor: AppColors.userMessageBG,
      indicatorColor: AppColors.botMatchedQsBG,
      disabledColor: AppColors.disabledColor,);

  static final darkTheme = ThemeData(
    primaryColor: AppColors.theme,
    shadowColor: AppColors.white,
    primaryColorLight: AppColors.black,
    primaryColorDark: AppColors.themeLight,
    brightness: Brightness.dark,
    dividerColor: AppColors.textfieldBorderDark,
    hintColor: AppColors.grey.withOpacity(0.8),
    cardColor: AppColors.botMessageBGDark,
    canvasColor: AppColors.userMessageBGDark,
    indicatorColor: AppColors.botMatchedQsBGDark,
    disabledColor: AppColors.disabledColor,

   
  );
}