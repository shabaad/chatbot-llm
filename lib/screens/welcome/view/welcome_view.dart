import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../common_utils/common_widgets.dart';
import '../../../reusable_widget/theme_button.dart';
import '../../../routeInfo/route_name.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_style.dart';
import '../controller/welcome_controller.dart';

class WelcomeView extends StatelessWidget {
  WelcomeView({super.key});

  final WelcomeController welcomeController = Get.put(WelcomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               SizedBox(
                height: MediaQuery.of(context).size.height / 2.5,
              ),
              _buildWelcomeView(context),
              Obx(() => Center(
                    child: commonText14w700(
                      welcomeController.appVersion.value,
                    ),
                  )),
              SizedBox(
                height: 20.0.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeView(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          
            Center(child: commonText40w700('welcomeToChatbotllm')),
              SizedBox(
              height: 40.h,
            ),
            SizedBox(
              height: 15.h,
            ),
      
            SizedBox(
              height: 10.h,
            ),
            Obx(
              () => ThemeButton(
                color: AppColors.theme,
                centreWidget: welcomeController.isLoading.value
                    ? const ButtonLoader()
                    : Text(
                        'signIn'.tr,
                        style: AppTextStyle.white16w600,
                      ),
                textStyle: AppTextStyle.white16w600,
                onPress: () {
                  Get.toNamed(RouteName.signInScreen);
                },
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(12.sp),
                    // border: Border.all(color: AppColors.disableButtonBorer),
                    boxShadow: const [
                      BoxShadow(
                          color: AppColors.disablethemeShadow,
                          blurRadius: 2,
                          offset: Offset(0, 1))
                    ]),
              ),
            ),
            SizedBox(
              height: 20.0.h,
            ),
          ].animate().slide().fadeIn(duration: 1000.ms)),
    );
  }
}
