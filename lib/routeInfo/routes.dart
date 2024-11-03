import 'package:get/get.dart';

import '../screens/auth/enter_otp/binding/enter_otp_binding.dart';
import '../screens/auth/enter_otp/view/enter_otp_view.dart';
import '../screens/auth/signin/binding/signin_binding.dart';
import '../screens/auth/signin/view/signin_view.dart';
import '../screens/chat/binding/chat_binding.dart';
import '../screens/chat/view/chat_view.dart';

import '../screens/splash_screen/binding/splash_binding.dart';
import '../screens/splash_screen/view/splash_view.dart';
import '../screens/theme/view/theme_view.dart';
import '../screens/welcome/view/welcome_view.dart';
import 'route_name.dart';

class Routes {
  static final pages = [
    GetPage(
        name: RouteName.splashScreen,
        page: () => SplashView(),
        binding: SplashBinding()),

    GetPage(
      name: RouteName.chatScreen,
      transition: Transition.native,
      page: () => ChatView(),
      binding: ChatBinding(),
    ),
  
    GetPage(
        name: RouteName.signInScreen,
        transition: Transition.native,
        page: () => SignInView(),
        binding: SignInBinding()),
   
    GetPage(
        name: RouteName.enterOtpScreen,
        transition: Transition.rightToLeft,
        transitionDuration: Duration(milliseconds: 350),
        page: () => EnterOtpView(),
        binding: EnterOtpBinding()),

    GetPage(
      name: RouteName.welcomeScreen,
      transition: Transition.native,
      page: () => WelcomeView(),
    ),
      GetPage(
      name: RouteName.themeScreen,
      transition: Transition.native,
      page: () => ThemeView(),
    ),
  
  ];
}
