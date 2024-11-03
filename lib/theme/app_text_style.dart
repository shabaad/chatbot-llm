import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

class AppTextStyle {
  AppTextStyle._();

  static final theme14w400 = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.theme,
  );

  static final normal14w400 = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
  );
  static const normal14w600 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );

  static final normal16w400 = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
  );

  static final normal16w700 = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
  );
  static final normal20w600 = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
  );

  static final white16w700 = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
  );

  static final white16w600 = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
  );

  static final black16w700 = TextStyle(
   fontSize: 16.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.black,
  );

  static final greyDisabledText16w600 = TextStyle(
      fontSize: 16.sp, fontWeight: FontWeight.w600, color: AppColors.white);

  static final grey15w400 = TextStyle(
      fontSize: 15.sp, fontWeight: FontWeight.w400, color: AppColors.theme);

  static const white18bold = TextStyle(
      fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.white);
}
