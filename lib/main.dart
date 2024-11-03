import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'common_utils/constants.dart';
import 'data/secrets.dart';
import 'routeInfo/route_name.dart';
import 'routeInfo/routes.dart';
import 'screens/splash_screen/binding/splash_binding.dart';
import 'translation/languages.dart';
import 'screens/theme/controller/theme_controller.dart';
import 'theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: Secrets.projectUrl,
    anonKey: Secrets.apiKey,
  );
  runApp(ChatBotLLM());
   final prefs = await SharedPreferences.getInstance();
  prefs.setString(Constants.accessToken, Secrets.cohereApiKey);
}

class ChatBotLLM extends StatelessWidget {
  ChatBotLLM({super.key});

  final ThemeController _themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
  
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: Size(context.width, context.height),
      builder: (BuildContext context, Widget? child) {
        return Obx(
          () => GetMaterialApp(
            theme: AppThemes.lightTheme,
            darkTheme: AppThemes.darkTheme,
            themeMode: _themeController.theme,
            initialBinding: SplashBinding(),
            debugShowCheckedModeBanner: false,
            getPages: Routes.pages,
            translations: Languages(),
            initialRoute: RouteName.splashScreen,
            locale: const Locale('en', 'US'),
          ),
        );
      },
    );
  }
}
