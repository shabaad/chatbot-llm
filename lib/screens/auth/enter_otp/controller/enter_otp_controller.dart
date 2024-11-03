import 'dart:async';

import 'package:chatbot_llm/data/secrets.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../common_utils/common_dialogs.dart';
import '../../../../common_utils/common_methods.dart';
import '../../../../common_utils/constants.dart';
import '../../../../routeInfo/route_name.dart';

class EnterOtpController extends GetxController {
  late Timer timer;
  RxInt minutesRemaining = 01.obs;
  RxInt secondsRemaining = 60.obs;
  RxBool enableResend = false.obs;
  RxBool isLoginEnabled = false.obs;
  RxString finalOtp = "".obs;
  String phoneNumber = "";
  String previousScreenName = "";

  RxBool isLoading = false.obs;

  RxBool inValidOtp = false.obs;

  TextEditingController textEditingController = TextEditingController();

  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  RxString currentText = "".obs;

  String message = '';

  @override
  void onReady() {
    super.onReady();
    enableResend = false.obs;
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (secondsRemaining.value != 0) {
        secondsRemaining.value--;
      } else {
        if (minutesRemaining.value == 0) {
          enableResend.value = true;
          timer.cancel();
        } else {
          secondsRemaining.value = 59;
          minutesRemaining.value--;
        }
      }
    });
  }

  Future<dynamic> verifyOtp(context) async {
    inValidOtp.value = false;

    isLoading(true);

    try {
      final AuthResponse response =
          await Supabase.instance.client.auth.verifyOTP(
        phone:Constants.countryCode +  phoneNumber,
        token: finalOtp.value,
        type: OtpType.sms,
      );
      if (response.session != null) {
        message = 'Otp verified successfully';
        await saveAuthData(
            Secrets.cohereApiKey,
            phoneNumber.contains('+')
                ? phoneNumber
                : Constants.countryCode + phoneNumber);
        CommonDialog.toaster(message, context);

        Get.offAllNamed(RouteName.chatScreen);
      } else {
        message = 'Internal server error';
        CommonDialog.errorToaster(message, context);
      }
    } catch (e) {
      // checkMandatoryfieldsEmptyOrNot();
      debugPrint(e.toString());
      inValidOtp(true);
      message = 'Invalid otp';
      CommonDialog.errorToaster(message, context);
      textEditingController.clear();
      finalOtp.value = '';
    } finally {
      isLoading(false);
    }
  }

  Future<dynamic> resendOTP(context) async {
    CommonDialog.errorToaster('Resend otp is limited', context);
  }

  void clearFields() {
    finalOtp.value = "";
    inValidOtp.value = false;
    minutesRemaining = 01.obs;
    secondsRemaining = 60.obs;
    enableResend.value = false;
  }

  saveAuthData(String accessToken, String phoneNumber) {
    saveAuthDataToStorage(accessToken, phoneNumber);
    saveBoolDataToStorage(Constants.isLoggedIn, true);
  }

  void checkMandatoryfieldsEmptyOrNot() {
    if (finalOtp.value.length == 6) {
      isLoginEnabled.value = true;
    } else {
      isLoginEnabled.value = false;
    }
  }
}
