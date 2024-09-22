import 'package:d_liv/screens/auth/confirm_token_screen.dart';
import 'package:d_liv/screens/auth/login/login_screen.dart';
import 'package:d_liv/screens/auth/onboarding_screen.dart';
import 'package:d_liv/screens/auth/reset_password/confirm_password_token_screen.dart';
import 'package:d_liv/screens/auth/reset_password/forgot_password_screen.dart';
import 'package:d_liv/screens/auth/reset_password/reset_password_screen.dart';
import 'package:d_liv/screens/auth/signup_guest_screen.dart';
import 'package:d_liv/screens/auth/signup_phone_screen.dart';
import 'package:d_liv/screens/auth/signup_screen.dart';
import 'package:d_liv/screens/home/home_screen.dart';
import 'package:d_liv/screens/onboarding_page.dart';
import 'package:d_liv/screens/profils/assistance_screen.dart';
import 'package:d_liv/screens/profils/edit_phone_screen.dart';
import 'package:d_liv/screens/profils/histories_screen.dart';
import 'package:d_liv/screens/profils/infos_screen.dart';
import 'package:d_liv/screens/profils/me_screen.dart';
import 'package:d_liv/screens/profils/security_screen.dart';
import 'package:d_liv/screens/profils/settings_screen.dart';
import 'package:d_liv/screens/splash_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class Routes {
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  //auth
  static const String auth = '/auth';
  static const String login = '/login';
  static const String forgotPassword = '/auth/forgot-password';
  static const String confirmPasswordToken = '/auth/confirm-password-token';
  static const String resetPassword = '/auth/reset-password';
  static const String signUp = '/signup';
  static const String signUpGuest = '/signUp/guest';
  static const String signUpPhone = '/auth/signup-phone';
  static const String signUpPhoneConfirm = '/auth/signup-phone/confirm';
  static const String confirmToken = '/auth/confirm-token';
  //profile
  static const String profile = '/profile';
  static const String security = '/profile/security';
  static const String assistance = '/profile/assistance';
  static const String settings = '/profile/settings';
  static const String home = '/';
  static const String histories = '/profile/histories';
  static const String info = '/profile/info';
  static const String editPhone = '/profile/edit-phone';
  static const String editEmail = '/profile/edit-email';

}

List<GetPage> routes = [
  GetPage(name: Routes.splash, page: () => const SplashScreen()),
  GetPage(name: Routes.onboarding, page: () => OnboardingPage()),
  GetPage(name: Routes.auth, page: () => const AuthScreen()),
  GetPage(name: Routes.login, page: () => const LoginScreen()),
  GetPage(name: Routes.forgotPassword, page: () => const ForgotPasswordScreen()),
  GetPage(name: Routes.confirmPasswordToken, page: () => const ConfirmPasswordTokenScreen()),
  GetPage(name: Routes.resetPassword, page: () => const ResetPasswordScreen()),
  GetPage(name: Routes.signUp, page: () => SignUpScreen()),
  GetPage(name: Routes.signUpPhone, page: () => const SignupPhoneScreen()),
  GetPage(name: Routes.signUpPhoneConfirm, page: () => const SignupPhoneScreen()),
  GetPage(name: Routes.confirmToken, page: () => const ConfirmTokenScreen()),
  GetPage(name: Routes.profile, page: () => const MeScreen()),
  GetPage(name: Routes.security, page: () => SecurityScreen()),
  GetPage(name: Routes.assistance, page: () => const AssistanceScreen()),
  GetPage(name: Routes.settings, page: () => const SettingsScreen()),
  GetPage(name: Routes.home, page: () => const HomeScreen()),
  GetPage(name: Routes.histories, page: () => const HistoriesScreen()),
  GetPage(name: Routes.info, page: () => const InfosScreen()),
  GetPage(name: Routes.editPhone, page: () => const EditPhoneScreen()),
  GetPage(name: Routes.signUpGuest, page: () => const SignUpGuestScreen()),

];