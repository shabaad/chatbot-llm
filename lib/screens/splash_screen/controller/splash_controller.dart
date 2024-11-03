import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common_utils/common_methods.dart';
import '../../../common_utils/constants.dart';
import '../../../common_utils/version_service.dart';
import '../../../routeInfo/route_name.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    navigate();
  }

  bool isEulaAccepted = true;

  Future<void> navigate() async {
    bool isLoggedIn = await getBoolDataToStorage(Constants.isLoggedIn);
    await Future.delayed(const Duration(milliseconds: 1000), () async {
      if (isLoggedIn) {
        Get.offAndToNamed<dynamic>(RouteName.chatScreen);
      } else {
        Get.offAndToNamed<dynamic>(RouteName.welcomeScreen);
      }
    });
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    Get.delete<SplashController>();
  }
}
