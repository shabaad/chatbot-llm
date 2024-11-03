
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common_utils/common_widgets.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_style.dart';
import '../controller/theme_controller.dart';

class ThemeView extends StatelessWidget {
  // Get the ThemeController instance
  final ThemeController _themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
             backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'Theme',
          style: AppTextStyle.white18bold,
        ),
        leading: CommonBackButton(
          color: AppColors.white,
        ),
          ),
      body: Center(
        child: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10.0.h,),
              ThemeSelectionTile(
                themeMode: ThemeMode.dark,
                selectedThemeMode: _themeController.themeMode.value,
                onPressed: () {
                  _themeController.setThemeMode(ThemeMode.dark);
                },
                label: 'Dark',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Divider(),
              ),
              ThemeSelectionTile(
                themeMode: ThemeMode.light,
                selectedThemeMode: _themeController.themeMode.value,
                onPressed: () {
                  _themeController.setThemeMode(ThemeMode.light);
                },
                label: 'Light',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Divider(),
              ),
              ThemeSelectionTile(
                themeMode: ThemeMode.system,
                selectedThemeMode: _themeController.themeMode.value,
                onPressed: () {
                  _themeController.setThemeMode(ThemeMode.system);
                },
                label: 'System',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ThemeSelectionTile extends StatelessWidget {
  final ThemeMode themeMode;
  final ThemeMode selectedThemeMode;
  final VoidCallback onPressed;
  final String label;

  ThemeSelectionTile({
    required this.themeMode,
    required this.selectedThemeMode,
    required this.onPressed,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    bool isSelected = themeMode == selectedThemeMode;
    return ListTile(
      title: commonText14W600(label,align: TextAlign.start),
      trailing: isSelected ? Icon(Icons.check) : SizedBox(),
      onTap: onPressed,
    ).animate().slide().fadeIn(duration: 600.ms);
  }
}

