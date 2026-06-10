import 'package:get/get.dart';

import '../../view/components/custom_Controller/custom_controller.dart';
import '../../view/screen/Login_role/login_controller.dart';



class DependencyInjection extends Bindings {
  @override
  void dependencies() {
    ///==========================Default Custom Controller ==================
    Get.lazyPut(() => CustomController(), fenix: true);

    ///==========================Login Controller ============================
    Get.lazyPut(() => LoginController(), fenix: true);
  }
}
