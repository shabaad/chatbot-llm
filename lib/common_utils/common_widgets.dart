import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../reusable_widget/theme_button.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_style.dart';

class CommonBackButton extends StatelessWidget {
  final Color? color;
  final VoidCallback? onBackPressed;

  const CommonBackButton(
      {super.key, this.color = AppColors.black, this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onBackPressed ?? () => Get.back(),
        icon: Icon(
          Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios,
          color: color,
          size: 30,
        ));
  }
}

class ButtonLoader extends StatelessWidget {
  const ButtonLoader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 15.0.h,
        width: 15.0.w,
        child:  LoadingAnimationWidget.horizontalRotatingDots(
          size: 30,
          color: AppColors.white,
        ));
  }
}


class RetryWidget extends StatelessWidget {
  const RetryWidget({
    super.key,
    required this.onPress,
  });

  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        
        Padding(
          padding: const EdgeInsets.all(15),
          child: Text('Sorry, something went wrong.\nPlease click here to try again',style: AppTextStyle.normal14w600,textAlign: TextAlign.center,),
        ),
         SizedBox(
          width: Get.width / 3,
          child: ThemeButton(
              color: AppColors.theme,
              onPress: onPress,
              textStyle: AppTextStyle.white16w700,
              centreWidget: Text(
                'Retry',
                style: AppTextStyle.white16w600,
              )))
      ],),
    );
  }
}

Text commonText14w700(String text,{TextAlign align= TextAlign.start}) {
  return Text(
    text.tr,
    style:
        TextStyle( fontSize: 14.0.sp, fontWeight: FontWeight.w700,),textAlign: align,
  );
}

Text commonText14W600(String text,{TextAlign? align = TextAlign.center}) {
  return Text(
    text.tr,
    style:
        TextStyle( fontSize: 14.0.sp, fontWeight: FontWeight.w600,),textAlign:align,
  );
}

Text commonThemeText14(String text, Color color) {
  return Text(
    text.tr,
    style: TextStyle( fontSize: 14, color: color),
  );
}

Text commonThemeText16w700(String text, context) {
  return Text(
    text.tr,
    style: TextStyle(
       
        fontSize: 16.0.sp,
        color: Theme.of(context).primaryColorDark,
        fontWeight: FontWeight.w700,),
        textAlign: TextAlign.center,
  );
}

Text commonThemeText16BoldHt3(String text) {
  return Text(
    text.tr,
    style: const TextStyle(
        height: 3,
        fontSize: 16,
        color: AppColors.theme,
        fontWeight: FontWeight.bold),
  );
}

Text commonText40w700(String text) {
  return Text(
    text.tr,
    style:
        const TextStyle( fontSize: 40, fontWeight: FontWeight.w700),textAlign: TextAlign.center,
  );
}
