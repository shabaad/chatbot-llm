import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../common_utils/common_dialogs.dart';
import '../../../../common_utils/common_widgets.dart';
import '../../../../common_utils/constants.dart';
import '../../../../reusable_widget/reusable_phone_field.dart';
import '../../../../reusable_widget/theme_button.dart';
import '../../../../routeInfo/route_name.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_text_style.dart';
import '../controller/signin_controller.dart';

class SignInView extends GetView<SignInController> {
  SignInView({Key? key}) : super(key: key);
  // RxString finalOtp = "".obs;
  @override
  Widget build(BuildContext context) {
    controller.enableResend = false.obs;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        Get.offAllNamed(RouteName.welcomeScreen);
        return;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 3,
              ),
              _buildSignInnview(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSignInnview(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: Form(
        key: controller.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           
            commonText40w700('signIn'),
            SizedBox(
              height: 50.h,
            ),
            commonText14w700('phoneNumber'),
            SizedBox(
              height: 10.h,
            ),
            Obx(
              () => ReusablePhoneField(
                countryCode: controller.countryCode.value,
                borderColor: Theme.of(context).dividerColor,
                fillColor: AppColors.textfieldFill,
                controller: controller.phoneController,
                keyBoardType: TextInputType.number,
                hinText: 'enterYourPhoneNumber'.tr,
                hintStyle:
                    TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                textCapitalization: TextCapitalization.characters,
                obscureText: false,
                fieldLength: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                onchange: (s) {
                  controller.checkMandatoryfieldsEmptyOrNot();
                },
                onFieldSubmitted: (value) {
                  // Handle the value submitted from the TextFormField
                  signIn(context);
                },
              ),
            ),
        
            // ),
            SizedBox(
              height: 30.0.h,
            ),
            Column(
              children: [
                Obx(() => ThemeButton(
                      color: AppColors.theme,
                      centreWidget: controller.isLoading.value
                          ? const ButtonLoader()
                          : Text(
                              'Get OTP'.tr,
                              style: AppTextStyle.white16w600,
                            ),
                      textStyle: AppTextStyle.white16w600,
                      onPress: () {
                        signIn(context);
                      },
                      decoration: BoxDecoration(
                          color: controller.isLogInEnabled.isTrue
                              ? Theme.of(context).primaryColor
                              : AppColors.disableThemeButton,
                          borderRadius: BorderRadius.circular(12.sp),
                          // border: Border.all(color: AppColors.disableButtonBorer),
                          boxShadow: const [
                            BoxShadow(
                                color: AppColors.disablethemeShadow,
                                blurRadius: 2,
                                offset: Offset(0, 1))
                          ]),
                    )),
                SizedBox(
                  height: 20.0.h,
                ),
              ],
            ),
            SizedBox(
              height: 20.0.h,
            ),
          ]
              .animate(interval: Duration(milliseconds: 50))
              .slideX(curve: Curves.decelerate)
              .fadeIn(delay: Duration(milliseconds: 100)),
        ),
      ),
    );
  }

  void signIn(BuildContext context) {
    // Get.toNamed(RouteName.enterOtpScreen);

    if (controller.phoneController.text.length != 10) {
      Future.delayed(Duration(milliseconds: 300), () {
        CommonDialog.errorToaster('Please enter valid phone number', context);
      });
    } else {
      if (controller.isLogInEnabled.isTrue) {
        if (controller.phoneController.text.trim().isEmpty) {
          CommonDialog.showErrorSnackbar(
              'Login Failed', 'Please Enter your Phone No');
        } else {
          if (controller.formKey.currentState!.validate()) {
            if (!controller.isLoading.value) {
              controller.signIn(context);
            }
          }
        }
      }
    }
  }
}
