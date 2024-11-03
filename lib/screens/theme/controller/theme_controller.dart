
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  var themeMode = ThemeMode.system.obs;
  ThemeMode get theme => themeMode.value;

  @override
  void onInit() {
    super.onInit();
    _loadTheme();
  }

  // Load the theme from SharedPreferences
  void _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int themeIndex = prefs.getInt('themeMode') ?? 0;
    themeMode.value = ThemeMode.values[themeIndex];
  }

  // Set the theme and save the preference
  void setThemeMode(ThemeMode mode) async {
    themeMode.value = mode;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('themeMode', mode.index);
  }
}
