import 'package:chatbot_llm/common_utils/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../theme/app_colors.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

 @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.themeLight,
        body: Center(child: Text('Chatbot LLM',style: TextStyle(color: AppColors.theme, fontSize: 40,fontWeight: FontWeight.bold,wordSpacing: 2),).animate().scaleXY(),));
  }
}

