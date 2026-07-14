import 'package:get/get_navigation/src/routes/get_route.dart';
import '../../view/screen/role_screen/parents/views/parent_chat_screen/view/parents_chat_list_screen.dart';
import '../../view/screen/role_screen/parents/views/parents_home_screen.dart';
import '../../view/screen/role_screen/parents/views/parents_profile_screen/change_password_screen.dart';
import '../../view/screen/role_screen/parents/views/parents_profile_screen/edit_profile_screen.dart';
import '../../view/screen/role_screen/parents/views/praents_student_view_profile.dart';
import '../../view/screen/role_screen/school_nurse/view/school_nurse_home/view/school_nurse_home_screen.dart';
import '../../view/screen/role_screen/school_nurse/view/school_nurse_profile/view/school_nurse_incident_reporting.dart';
import '../../view/screen/role_screen/student/view/student_home/student_home_screen.dart';
import '../../view/screen/role_screen/student/view/student_profile/view/student_fees_screen.dart';
import '../../view/screen/role_screen/student/view/student_profile/view/student_metarial_screen.dart';
import '../../view/screen/role_screen/student/view/student_profile/view/student_schedule_screen.dart';
import '../../view/screen/role_screen/student/view/student_profile/view/student_support_screen.dart';
import '../../view/screen/role_screen/teachers/teachers_assignment/views/teachers_assignment_screen.dart';
import '../../view/screen/role_screen/teachers/teachers_attendance/teachers_attendance_screen.dart';
import '../../view/screen/role_screen/teachers/teachers_home/screen/teachers_home_screen.dart';
import '../../view/screen/role_screen/teachers/teachers_home/screen/details_schedule_screen.dart';
import '../../view/screen/role_screen/teachers/teachers_home/screen/all_assignments_screen.dart';
import '../../view/screen/role_screen/teachers/teachers_home/screen/all_announcements_screen.dart';
import '../../view/screen/role_screen/teachers/teacher_exam_secren/screen/teacher_exam_grade_screen.dart';
import '../../view/screen/role_screen/teachers/teacher_exam_secren/screen/teacher_create_exam_screen.dart';
import '../../view/screen/role_screen/teachers/teacher_exam_secren/screen/teacher_student_submissions_screen.dart';
import '../../view/screen/role_screen/teachers/teacher_exam_secren/screen/teacher_view_results_screen.dart';
import '../../view/screen/role_screen/teachers/teachers_profile/view/teacher_schedule_screen.dart';
import '../../view/screen/role_screen/teachers/teachers_profile/view/teacher_student_screen.dart';
import '../../view/screen/role_screen/teachers/teachers_profile/view/teachers_material.dart';
import '../../view/screen/Login_role/login.dart';
import '../../view/screen/Login_role/forgot_password_screen.dart';
import '../../view/screen/Login_role/verification_otp_forget_pass_screen.dart';
import '../../view/screen/Login_role/reset_password_screen.dart';
import '../../view/screen/role_screen/teachers/teachers_recording_classes/screen/video_player_screen.dart';

class AppRoutes {
  ///=========================== Student Part ===============
  static const String splashScreen = "/SplashScreen";
  static const String editScreen = "/EditScreen";
  static const String changePassScreen = "/ChangePassScreen";
  static const String chatListScreen = "/ChatListScreen";

  static const String demo = "/Demo";
  static const String loginScreen = "/LoginScreen";
  static const String forgotPasswordScreen = "/ForgotPasswordScreen";
  static const String verificationOtpForgetPass =
      "/VerificationOtpForgetPassScreen";
  static const String resetPasswordScreen = "/ResetPasswordScreen";

  ///=================== Students Part ======================
  static const String studentHomeScreen = "/StudentHomeScreen";
  static const String resourceListScreen = "/ResourceListScreen";
  static const String studentFeesScreen ="/StudentFeesScreen";
  static const String studentGradeScreen = "/StudentGradeScreen";
  static const String contactUsScreen = "/ContactUsScreen";
  static const String studentScheduleScreen = "/StudentScheduleScreen";

  ///=================== Teachers Part ======================
  static const String teachersHomeScreen = "/TeachersHomeScreen";
  static const String teachersMaterial = "/TeachersMaterial";
  static const String teacherExamGradeScreen = "/TeacherExamGradeScreen";
  static const String teacherCreateExamScreen = "/TeacherCreateExamScreen";
  static const String teacherStudentSubmissionsScreen =
      "/TeacherStudentSubmissionsScreen";
  static const String teacherViewResultsScreen = "/TeacherViewResultsScreen";
  static const String teacherScheduleScreen = "/TeacherScheduleScreen";
  static const String teacherStudentScreen = "/TeacherStudentScreen";
  static const String teachersAssignmentScreen = "/TeachersAssignmentScreen";
  static const String teachersAttendanceScreen = "/TeachersAttendanceScreen";
  static const String detailsScheduleScreen = "/DetailsScheduleScreen";
  static const String allAssignmentsScreen = "/AllAssignmentsScreen";
  static const String allAnnouncementsScreen = "/AllAnnouncementsScreen";
  static const String videoPlayerScreen = "/VideoPlayerScreen";

  ///=================== School Nurse Part ======================
  static const String schoolNurseHomeScreen = "/SchoolNurseHomeScreen";
  static const String schoolNurseIncidentReporting =
      "/SchoolNurseIncidentReporting";

  ///=================== Students Part ======================
  static const String parentsHomeScreen = "/ParentsHomeScreen";
  static const String praentsStudentViewProfile = "/PraentsStudentViewProfile";

  static List<GetPage> routes = [
    ///=========================== Student Part ==============

    GetPage(name: loginScreen, page: () => const LoginScreen()),

    ///===================== Student Part================
    GetPage(name: studentHomeScreen, page: () => StudentHomeScreen()),
    GetPage(name: resourceListScreen, page: () => const StudentMetarialScreen()),
    GetPage(name: studentFeesScreen, page: () => const StudentFeesScreen()),
    GetPage(name: contactUsScreen, page: () => ContactUsScreen()),
    GetPage(name: studentScheduleScreen, page: () => StudentScheduleScreen()),

    ///===================== Teachers Part================
    GetPage(name: teachersHomeScreen, page: () => TeachersHomeScreen()),
    GetPage(name: teachersMaterial, page: () => TeachersMaterial()),
    GetPage(name: teacherExamGradeScreen, page: () => TeacherExamGradeScreen()),
    GetPage(
        name: teacherCreateExamScreen, page: () => TeacherCreateExamScreen()),
    GetPage(
        name: teacherStudentSubmissionsScreen,
        page: () => TeacherStudentSubmissionsScreen()),
    GetPage(
        name: teacherViewResultsScreen, page: () => TeacherViewResultsScreen()),
    GetPage(name: teacherScheduleScreen, page: () => TeacherScheduleScreen()),
    GetPage(name: teacherStudentScreen, page: () => TeacherStudentScreen()),
    GetPage(
        name: teachersAssignmentScreen, page: () => TeachersAssignmentScreen()),
    GetPage(
        name: teachersAttendanceScreen, page: () => TeachersAttendanceScreen()),
    GetPage(
        name: detailsScheduleScreen, page: () => const DetailsScheduleScreen()),
    GetPage(name: allAssignmentsScreen, page: () => AllAssignmentsScreen()),
    GetPage(name: allAnnouncementsScreen, page: () => AllAnnouncementsScreen()),
    GetPage(name: videoPlayerScreen, page: () => VideoPlayerScreen()),

    ///===================== School Nurse Part================
    GetPage(name: schoolNurseHomeScreen, page: () => SchoolNurseHomeScreen()),
    GetPage(
        name: schoolNurseIncidentReporting,
        page: () => SchoolNurseIncidentReporting()),

    ///===================== Parents Part================
    GetPage(name: parentsHomeScreen, page: () => ParentsHomeScreen()),
    GetPage(name: editScreen, page: () => EditScreen()),
    GetPage(name: changePassScreen, page: () => ChangePassScreen()),
    GetPage(name: chatListScreen, page: () => ChatListScreen()),
    GetPage(
        name: praentsStudentViewProfile,
        page: () => PraentsStudentViewProfile()),

    // Auth Routes
    GetPage(
        name: forgotPasswordScreen, page: () => const ForgotPasswordScreen()),
    GetPage(
        name: verificationOtpForgetPass,
        page: () => const VerificationOtpForgetPassScreen()),
    GetPage(name: resetPasswordScreen, page: () => const ResetPasswordScreen()),
  ];
}
