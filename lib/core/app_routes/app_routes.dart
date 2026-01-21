import 'package:get/get_navigation/src/routes/get_route.dart';
import '../../view/screen/role_screen/demo/demo.dart';
import '../../view/screen/role_screen/parents/views/parent_chat_screen/view/parents_chat_list_screen.dart';
import '../../view/screen/role_screen/parents/views/parents_home_screen.dart';
import '../../view/screen/role_screen/parents/views/parents_profile_screen/change_password_screen.dart';
import '../../view/screen/role_screen/parents/views/parents_profile_screen/edit_profile_screen.dart';
import '../../view/screen/role_screen/school_nurse/view/school_nurse_home/view/school_nurse_home_screen.dart';
import '../../view/screen/role_screen/school_nurse/view/school_nurse_profile/view/school_nurse_incident_reporting.dart';
import '../../view/screen/role_screen/student/view/student_home/student_home_screen.dart';
import '../../view/screen/role_screen/student/view/student_profile/view/schedule_list_screen.dart';
import '../../view/screen/role_screen/student/view/student_profile/view/student_grade_screen.dart';
import '../../view/screen/role_screen/student/view/student_profile/view/student_schedule_screen.dart';
import '../../view/screen/role_screen/student/view/student_profile/view/student_support_screen.dart';
import '../../view/screen/role_screen/teachers/teachers_home/teachers_home_screen.dart';
import '../../view/screen/role_screen/teachers/teachers_profile/view/teacher_exam_grade_screen.dart';
import '../../view/screen/role_screen/teachers/teachers_profile/view/teacher_schedule_screen.dart';
import '../../view/screen/role_screen/teachers/teachers_profile/view/teachers_material.dart';

class AppRoutes {
  ///=========================== Student Part ===============
  static const String splashScreen = "/SplashScreen";
  static const String editScreen = "/EditScreen";
  static const String changePassScreen = "/ChangePassScreen";
  static const String chatListScreen = "/ChatListScreen";

  static const String demo = "/Demo";


  ///=================== Students Part ======================
  static const String studentHomeScreen ="/StudentHomeScreen";
  static const String resourceListScreen ="/ResourceListScreen";
  static const String studentGradeScreen ="/StudentGradeScreen";
  static const String contactUsScreen ="/ContactUsScreen";
  static const String studentScheduleScreen ="/StudentScheduleScreen";

  ///=================== Teachers Part ======================
  static const String teachersHomeScreen ="/TeachersHomeScreen";
  static const String teachersMaterial ="/TeachersMaterial";
  static const String teacherExamGradeScreen ="/TeacherExamGradeScreen";
  static const String teacherScheduleScreen ="/TeacherScheduleScreen";

  ///=================== School Nurse Part ======================
  static const String schoolNurseHomeScreen ="/SchoolNurseHomeScreen";
  static const String schoolNurseIncidentReporting ="/SchoolNurseIncidentReporting";

  ///=================== Students Part ======================
  static const String parentsHomeScreen ="/ParentsHomeScreen";



  static List<GetPage> routes = [
    ///=========================== Student Part ==============
    // GetPage(name: splashScreen, page: () => SplashScreen()),


    GetPage(name: demo, page: () => Demo()),


    ///===================== Student Part================
    GetPage(name: studentHomeScreen, page: () => StudentHomeScreen()),
    GetPage(name: resourceListScreen, page: () => ResourceListScreen()),
    GetPage(name: studentGradeScreen, page: () => StudentGradeScreen()),
    GetPage(name: contactUsScreen, page: () => ContactUsScreen()),
    GetPage(name: studentScheduleScreen, page: () => StudentScheduleScreen()),


    ///===================== Teachers Part================
    GetPage(name: teachersHomeScreen, page: () => TeachersHomeScreen()),
    GetPage(name: teachersMaterial, page: () => TeachersMaterial()),
    GetPage(name: teacherExamGradeScreen, page: () => TeacherExamGradeScreen()),
    GetPage(name: teacherScheduleScreen, page: () => TeacherScheduleScreen()),


   ///===================== School Nurse Part================
    GetPage(name: schoolNurseHomeScreen, page: () => SchoolNurseHomeScreen()),
    GetPage(name: schoolNurseIncidentReporting, page: () => SchoolNurseIncidentReporting()),

  ///===================== Parents Part================
    GetPage(name: parentsHomeScreen, page: () => ParentsHomeScreen()),
    GetPage(name: editScreen, page: () => EditScreen()),
    GetPage(name: changePassScreen, page: () => ChangePassScreen()),
    GetPage(name: chatListScreen, page: () => ChatListScreen()),



  ];
}
