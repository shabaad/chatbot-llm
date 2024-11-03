import 'dart:async';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../common_utils/common_methods.dart';
import '../../../common_utils/constants.dart';
import '../../../routeInfo/route_name.dart';

class WelcomeController extends GetxController {

  RxString appVersion = "".obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    accessNumber();
    _initPackageInfo();
  }

  void accessNumber() async {
    if (await Permission.phone.request().isGranted) {}
  }


  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    appVersion.value = "Version: ${info.version} (${info.buildNumber})";
  }

}
