import 'package:get/get.dart';

import '../controller/enter_otp_controller.dart';

class EnterOtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(() => EnterOtpController());
  }
}
