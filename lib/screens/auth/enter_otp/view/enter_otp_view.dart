
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


import '../../../../common_utils/common_dialogs.dart';
import '../../../../common_utils/common_widgets.dart';
import '../../../../common_utils/constants.dart';
import '../../../../reusable_widget/theme_button.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_text_style.dart';
import '../controller/enter_otp_controller.dart';

class EnterOtpView extends GetView<EnterOtpController> {
  EnterOtpView({Key? key}) : super(key: key);

  final EnterOtpController controller =
      Get.put(EnterOtpController());

  @override
  Widget build(BuildContext context) {
    if (Get.arguments != null) {
      if (Get.arguments[1] != null) {
        controller.phoneNumber = Get.arguments[1] as String;
      }
      if (Get.arguments[0] != null) {
        controller.previousScreenName = Get.arguments[0] as String;
      }
    }
    return Scaffold(
      body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(child: _buildEnterOtpView(context))),
    );
  }

  Widget _buildEnterOtpView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
     SizedBox(
                height: MediaQuery.of(context).size.height / 3.5,
              ),
        Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             
              Text(
                "Sent a verification code to ${controller.phoneNumber.contains('+') ? '' : Constants.countryCode}${controller.phoneNumber}",
                style: AppTextStyle.normal20w600,
              ),
              SizedBox(
                height: 70.h,
              ),
            
              Obx(
                () => PinCodeTextField(
                  appContext: context,
                  pastedTextStyle: TextStyle(
                    color: Colors.green.shade600,
                    fontWeight: FontWeight.bold,
                  ),
                  length: 6,
                  obscureText: false,
                  obscuringCharacter: '*',
                  animationType: AnimationType.scale,

                  pinTheme: PinTheme(
                    errorBorderColor: AppColors.black,
                    inactiveColor: Theme.of(context).dividerColor,
                    activeColor: controller.inValidOtp.isTrue
                        ? Colors.red
                        : Theme.of(context).shadowColor,
                    selectedColor: Theme.of(context).primaryColor,
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(15),
                    fieldHeight: 60.0.h,
                    fieldWidth: 50.0.w,
                    activeFillColor:
                        controller.hasError ? Colors.orange : Colors.white,
                  ),
                  cursorColor: Theme.of(context).primaryColorDark,
                  animationDuration: Duration(milliseconds: 300),
                  textStyle: TextStyle(fontSize: 20, height: 1.6),
                  errorAnimationController: controller.errorController,
                  controller: controller.textEditingController,
                  keyboardType: TextInputType.number,
                  boxShadows: [
                    BoxShadow(
                      offset: Offset(0, 1),
                      color: Colors.black12,
                      blurRadius: 10,
                    )
                  ],
                  onCompleted: (v) {
                    controller.finalOtp.value = v;
                    controller.checkMandatoryfieldsEmptyOrNot();
                    controller.inValidOtp(false);
                  },
                  onSubmitted: (value) {
                    if (controller.finalOtp.value.length != 6) {
                      Future.delayed(Duration(milliseconds: 300), () {
                        CommonDialog.errorToaster(
                            'Please enter full code', context);
                      });
                    } else {
                      verifyOtp(context);
                    }
                  },
                  // onTap: () {
                  //   print("Pressed");
                  // },
                  onChanged: (value) {
                    print(value);
                    controller.finalOtp.value = value;
                    controller.checkMandatoryfieldsEmptyOrNot();
                    if (controller.inValidOtp.isTrue) {
                      controller.inValidOtp(false);
                    }
                  },
                ),
              ),

              Obx(() => controller.inValidOtp.isTrue
                  ? Text(
                      'codeEnteredWrong'.tr,
                      style: TextStyle(color: Colors.red),
                    )
                  : const Offstage()),
              // OtpView(otpCallback: (String otp) {
              //   controller.finalOtp.value = otp;
              //   controller.checkMandatoryfieldsEmptyOrNot();
              // }),
              SizedBox(
                height: 23.h,
              ),

              Obx(
                () => ThemeButton(
                  color: controller.isLoginEnabled.isTrue
                      ? AppColors.theme
                      : AppColors.disableThemeButton,
                  textStyle: AppTextStyle.white16w600,
                  centreWidget: controller.isLoading.value
                      ? const ButtonLoader()
                      : Text(
                          'submit'.tr,
                          style: AppTextStyle.white16w600,
                        ),
                  onPress: () async {
                    verifyOtp(context);
                  },
                ),
              ),
              SizedBox(
                height: 20.0.h,
              ),
              Column(
                children: [
                  SizedBox(
                    child: GestureDetector(
                      onTap: () {
                        if (controller.enableResend.isTrue) {
                          controller.minutesRemaining = 01.obs;
                          controller.secondsRemaining = 60.obs;
                          controller.enableResend.value = false;
                          controller.startTimer();
                          controller.clearFields();
                          controller.resendOTP(context);
                        }
                      },
                      child: Center(
                        child: Obx(
                          () => Text(
                            controller.enableResend.isFalse
                                ? 'didntRecieveCode'.tr
                                : 'resendCode'.tr,
                            style: controller.enableResend.isFalse
                                ? TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w600)
                                : TextStyle(
                                    fontSize: 16.0.sp,
                                    color: Theme.of(context).primaryColorDark,
                                    fontWeight: FontWeight.w700),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Obx(
                    () => controller.enableResend.isFalse
                        ? Center(
                            child: commonThemeText16w700(
                                "Resend code in ${controller.minutesRemaining.value.toString().padLeft(2, '0')}:${controller.secondsRemaining.value.toString().padLeft(2, '0')}",
                                context),
                          )
                        : const Offstage(),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  void verifyOtp(BuildContext context) {
    if (controller.isLoading.value) {
    } else {
      if (controller.isLoginEnabled.isTrue) {
        if (controller.finalOtp.value != "") {
          if (!controller.isLoading.value) {
            FocusScope.of(context).unfocus();

            controller.verifyOtp(context);
          }
        } else {
          CommonDialog.toaster("pleaseEnterCode".tr, context);
        }
      }
    }
  }
}
