


import 'package:get/get_navigation/src/routes/get_route.dart';

import '../../view/screen/role_screen/demo/demo.dart';
import '../../view/screen/role_screen/institution/institution_home/institution_home_screen.dart';
import '../../view/screen/role_screen/parents/parents_home/parents_home_screen.dart';
import '../../view/screen/role_screen/student/student_home/student_home_screen.dart';
import '../../view/screen/role_screen/teachers/teachers_home/teachers_home_screen.dart';

class AppRoutes {
  ///=========================== Student Part ===============
  static const String splashScreen = "/SplashScreen";

  static const String demo = "/Demo";


  ///=================== Students Part ======================
  static const String studentHomeScreen ="/StudentHomeScreen";

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


    ///===================== Student Part================
    GetPage(name: teachersHomeScreen, page: () => TeachersHomeScreen()),


   ///===================== Student Part================
    GetPage(name: institutionHomeScreen, page: () => InstitutionHomeScreen()),

  ///===================== Student Part================
    GetPage(name: parentsHomeScreen, page: () => ParentsHomeScreen()),



  ];
}
