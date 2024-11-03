import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:url_launcher/url_launcher.dart';

import '../reusable_widget/theme_button.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_style.dart';
import 'constants.dart';


dynamic noInternetDialog() {
  return Get.dialog<dynamic>(
    Scaffold(
    body: SafeArea(
      child: AnimatedContainer(
        height: Get.height,
        width: Get.width,
        duration: const Duration(minutes: 2),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'pleaseCheckYourInternet'.tr,
                style: AppTextStyle.normal16w700,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20.0.h,
              ),
              SizedBox(
                  width: Get.width / 3,
                  child: ThemeButton(
                      color: AppColors.theme,
                      onPress: () => Get.back(),
                      textStyle: AppTextStyle.white16w700,
                      centreWidget: Text(
                        'Go back',
                        style: AppTextStyle.white16w600,
                      )))
            ],
          ),
        ),
      ),
    ),
  ),useSafeArea: false);
}

void saveIntDataToStorage(String key, int value) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setInt(key, value);
}

Future<int> getIntDataToStorage(String key) async {
  final prefs = await SharedPreferences.getInstance();
  int timestamp = prefs.getInt(key) ?? 0;
  return timestamp;
}

void saveStringDataToStorage(String key, String value) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
}

void saveAuthDataToStorage(
  String token,
  String phoneNumber,
) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString(Constants.accessToken, token);
  prefs.setString(Constants.phoneNumber, phoneNumber);
  log(token);
  log(phoneNumber);
}

Future<String> getStringDataToStorage(String key) async {
  final prefs = await SharedPreferences.getInstance();
  String data = prefs.getString(key) ?? "";
  return data;
}

void saveBoolDataToStorage(String key, bool value) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool(key, value);
}

Future<bool> getBoolDataToStorage(String key) async {
  final prefs = await SharedPreferences.getInstance();
  bool data = prefs.getBool(key) ?? false;
  return data;
}



