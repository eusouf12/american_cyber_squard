import 'package:get/get.dart';

import '../../view/components/custom_Controller/custom_controller.dart';



class DependencyInjection extends Bindings {
  @override
  void dependencies() {
    ///==========================Default Custom Controller ==================
    Get.lazyPut(() => CustomController(), fenix: true);
  }
}
