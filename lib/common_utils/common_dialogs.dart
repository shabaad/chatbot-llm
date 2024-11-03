import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../reusable_widget/theme_button.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_style.dart';

FToast? fToast;

class CommonDialog {
  static void toaster(title, context) {
    fToast = FToast();
    fToast!.init(context);
    fToast!.showToast(
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).primaryColorLight,
          boxShadow: [
            BoxShadow(
                color: Colors.black54,
                blurRadius: 5.0,
                offset: Offset(0.0, 0.75))
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check,
              color: Colors.green,
              size: 18,
            ),
            SizedBox(
              width: 5,
            ),
            Flexible(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            )
          ],
        ),
      ),
      gravity: ToastGravity.BOTTOM,
    );
  }

  static void errorToaster(title, context) {
    fToast = FToast();
    fToast!.init(context);
    fToast!.showToast(
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.black54,
                blurRadius: 5.0,
                offset: Offset(0.0, 0.75))
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.error,
              size: 18,
              color: AppColors.white,
            ),
            SizedBox(
              width: 5,
            ),
            Flexible(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: AppColors.white),
              ),
            )
          ],
        ),
      ),
      gravity: ToastGravity.BOTTOM,
    );
  }

  static void showErrorSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      // backgroundColor: Colors.white,
      // colorText: AppColors.signupColor,
      snackPosition: SnackPosition.TOP,
    );
  }

  static void showMessageSnackbar(String title, String message) {
    Get.snackbar(title, message, snackPosition: SnackPosition.TOP);
  }

  static showConfirmationDialog(String title, BuildContext context) {
    return showDialog<dynamic>(
        context: context,
        builder: (BuildContext context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  title,
                  style: AppTextStyle.normal20w600,
                ),
              )
            ],
          );
        });
  }

  static showOkDialog(String title, String content, BuildContext context,
      Function onOkayPressed,
      {bool okOnly = false,bool isReset = false}) {
    return showDialog<dynamic>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog.adaptive(
             actionsOverflowAlignment: OverflowBarAlignment.center,
            actionsAlignment: MainAxisAlignment.center,
              contentPadding: EdgeInsets.only(top: 12,left: 10,right: 10),
            // titlePadding: EdgeInsets.only(top: 12,left: 10,right: 10),
            actionsPadding: EdgeInsets.only(bottom: 5),
            title: Text(
              title,
              textAlign: TextAlign.center,
            ),
            content: Text(
              content,
               textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              if (!okOnly)
                TextButton(
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.red.shade500, fontWeight: FontWeight.w600,fontSize: 18),
                  ),
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    Get.back();
                  },
                ),
              TextButton(
                child: Text(
                  isReset ? 'Reset' :
                  okOnly ? 'Ok' : 'Confirm',
                  style: TextStyle(color: Theme.of(context).primaryColorDark,  fontWeight: FontWeight.w600,fontSize: 18),
                ),
                onPressed: () {
                  onOkayPressed.call();
                },
              ),
            ],
          ).animate().scale();
        });
  }

}
