import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_style.dart';

InputDecoration textfieldInputDecoration(BuildContext context, String label, {Widget? suffixIcon}) {
  return InputDecoration(
    fillColor: Colors.transparent,
    filled: true,
    isDense: true,
    // label: Text(label.tr),
    // suffixText: widget.suffixString,
    counterText: "",
    hintStyle: TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: Theme.of(context).hintColor
  ),
  errorStyle: TextStyle(
    color: Colors.red
  ),
    // suffixIconColor: Colors.red,
    // suffixStyle: widget.suffixStyle,
    hintText: label.tr,
    suffixIcon: suffixIcon ?? const SizedBox(),
   contentPadding: EdgeInsets.only(
                  left: 20.0.sp, top: 16.0.sp, bottom: 16.0.sp),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0.sp)),
      borderSide: BorderSide(
        width: 1.5.sp,
        color: Get.isDarkMode ? AppColors.white : AppColors.black
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0.sp)),
      borderSide: BorderSide(
        width: 1.5.sp,
        color: Theme.of(context).dividerColor
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0.sp)),
      borderSide: BorderSide(
        width: 1.5.sp,
        color: Colors.red
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0.sp)),
      borderSide: BorderSide(
        width: 2.sp,
        color: Colors.red
      ),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0.sp)),
      borderSide: BorderSide(
        width: 1.sp,
        color: Theme.of(context).dividerColor
      ),
    ),
    border: const OutlineInputBorder(),
    labelStyle: AppTextStyle.grey15w400,
  );
}
