import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_number/mobile_number.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../common_utils/common_dialogs.dart';
import '../../../../common_utils/constants.dart';
import '../../../../routeInfo/route_name.dart';

class SignInController extends GetxController {


  late Timer timer;
  RxInt secondsRemaining = 10.obs;
  RxBool enableResend = false.obs;

  RxBool isLogInEnabled = false.obs;
  TextEditingController phoneController = TextEditingController();


  final formKey = GlobalKey<FormState>();

  RxBool isLoading = false.obs;


  String message = '';



  var mobileNumber = ''.obs;
  RxString countryCode = ''.obs;
  var simCards = <SimCard>[].obs;

  @override
  void onInit() {
    super.onInit();
    countryCode.value = Constants.countryCode;
    _getMobileNumber();
  }

  Future<void> _getMobileNumber() async {
    if (await Permission.phone.request().isGranted) {
      try {
        String? number = await MobileNumber.mobileNumber;
        List<SimCard>? sims = await MobileNumber.getSimCards;
        mobileNumber.value = number!;
        simCards.value = sims!;
        if (simCards.isNotEmpty) {
          String strippedNumber = simCards.first.number!.length == 11
              ? simCards.first.number!.substring(1)
              : simCards.first.number!.length == 12
                  ? simCards.first.number!.substring(2)
                  : simCards.first.number!.length == 13
                      ? simCards.first.number!.substring(3)
                      : simCards.first.number!;

          phoneController.text = strippedNumber;
          isLogInEnabled(true);
        }
      } catch (e) {
        mobileNumber.value = 'Failed to get mobile number';
      }
    } else {
      mobileNumber.value = 'Permission denied';
    }
  }


  Future<dynamic> signIn(context) async {
    isLoading(true);
    try {
      Map<String, dynamic> body = {
        "mobileNumber": Constants.countryCode + phoneController.text
      };
      final supabase = Supabase.instance.client;
      final response = await supabase.auth
          .signInWithOtp(phone: Constants.countryCode + phoneController.text);
      CommonDialog.toaster('Otp sent successfully', context);
      Get.toNamed(RouteName.enterOtpScreen,
          arguments: ['signin', phoneController.text]);
    } catch (e) {
      // checkMandatoryfieldsEmptyOrNot();
      debugPrint(e.toString());
      message = e.toString() ?? '';
      if (message.length < 150) {
        CommonDialog.errorToaster(message, context);
      } else {
        CommonDialog.showOkDialog(
            'Signin failed', message, context, () => Get.back(),
            okOnly: true);
      }
    } finally {
      isLoading(false);
    }
  }

  checkMandatoryfieldsEmptyOrNot() {
    if (phoneController.text.length != 10) {
      isLogInEnabled.value = false;
    } else {
      isLogInEnabled.value = true;
    }
  }

}
