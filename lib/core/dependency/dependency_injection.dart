import 'package:get/get.dart';

import '../../view/components/custom_Controller/custom_controller.dart';
import '../../view/components/custom_image_add_send/custom_image_add_send_controller.dart';
import '../../view/screen/Login_role/login_controller.dart';
import '../../view/screen/role_screen/parents/controller/parents_controller.dart';
import '../../view/screen/role_screen/parents/controller/academic_controller.dart';
import '../../view/screen/role_screen/school_nurse/view/immunization/controller/immunization_controller.dart';
import '../../view/screen/role_screen/student/controller/student_attandance_controller.dart';
import '../../view/screen/role_screen/student/controller/student_home_controller.dart';
import '../../view/screen/role_screen/student/view/student_profile/controller/student_shedule_controller.dart';
import '../../view/screen/role_screen/student/view/student_profile/controller/support_controller.dart';
import '../../view/screen/role_screen/teachers/teachers_assignment/controller/teacher_create_controller.dart';
import '../../view/screen/role_screen/teachers/teachers_attendance/controller/teacher_attendence_controller.dart';
import '../../view/screen/role_screen/teachers/teachers_home/controller/teachers_controller.dart';
import '../../view/screen/role_screen/teachers/teachers_profile/controller/teacher_student_controller.dart';
import '../../view/screen/role_screen/teachers/teachers_profile/controller/teachers_material_controller.dart';
import '../../view/screen/role_screen/teachers/teachers_recording_classes/controller/recording_class_controller.dart';

class DependencyInjection extends Bindings {
  @override
  void dependencies() {
    ///==========================Default Custom Controller ==================
    Get.lazyPut(() => CustomController(), fenix: true);

    ///==========================Login Controller ============================
    Get.lazyPut(() => LoginController(), fenix: true);

    ///==========================Parents & Academic Controllers ===============
    Get.lazyPut(() => ParentsController(), fenix: true);
    Get.lazyPut(() => TabControllerX(), fenix: true);

    ///==========================Nurse Controllers ===========================
    Get.lazyPut(() => ImmunizationController(), fenix: true);

    ///==========================Student Controllers =========================
    Get.lazyPut(() => StudentHomeController(), fenix: true);
    Get.lazyPut(() => StudentAttendanceController(), fenix: true);
    Get.lazyPut(() => StudentSheduleController(), fenix: true);
    Get.lazyPut(() => ContactUsController(), fenix: true);

    ///==========================Teacher Controllers =========================
    Get.lazyPut(() => TeachersController(), fenix: true);
    Get.lazyPut(() => RecordingClassController(), fenix: true);
    
    Get.lazyPut(() => TeachersMaterialController(), fenix: true);
    Get.lazyPut(() => TeacherStudentController(), fenix: true);
    Get.lazyPut(() => TeacherCreateController(), fenix: true);
    Get.lazyPut(() => TeacherAttendanceController(), fenix: true);

    ///==========================Common / Helper Controllers ==================
    Get.lazyPut(() => CustomImageAddSendController(), fenix: true);
  }
}
