import 'package:get/get_navigation/src/routes/get_route.dart';
import '../../view/screen/role_screen/demo/demo.dart';
import '../../view/screen/role_screen/institution/institution_home/institution_home_screen.dart';
import '../../view/screen/role_screen/parents/views/parent_chat_screen/view/parents_chat_list_screen.dart';
import '../../view/screen/role_screen/parents/views/parents_home_screen.dart';
import '../../view/screen/role_screen/parents/views/parents_profile_screen/change_password_screen.dart';
import '../../view/screen/role_screen/parents/views/parents_profile_screen/edit_profile_screen.dart';
import '../../view/screen/role_screen/student/view/student_home/student_home_screen.dart';
import '../../view/screen/role_screen/student/view/student_profile/view/schedule_list_screen.dart';
import '../../view/screen/role_screen/student/view/student_profile/view/student_grade_screen.dart';
import '../../view/screen/role_screen/student/view/student_profile/view/student_support_screen.dart';
import '../../view/screen/role_screen/teachers/teachers_home/teachers_home_screen.dart';

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

  ///=================== Teachers Part ======================
  static const String teachersHomeScreen ="/TeachersHomeScreen";

  ///=================== Students Part ======================
  static const String institutionHomeScreen ="/InstitutionHomeScreen";

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


    ///===================== Teachers Part================
    GetPage(name: teachersHomeScreen, page: () => TeachersHomeScreen()),


   ///===================== Student Part================
    GetPage(name: institutionHomeScreen, page: () => InstitutionHomeScreen()),

  ///===================== Parents Part================
    GetPage(name: parentsHomeScreen, page: () => ParentsHomeScreen()),
    GetPage(name: editScreen, page: () => EditScreen()),
    GetPage(name: changePassScreen, page: () => ChangePassScreen()),
    GetPage(name: chatListScreen, page: () => ChatListScreen()),



  ];
}
