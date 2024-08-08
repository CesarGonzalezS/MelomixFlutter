// routes.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:melomix/view/splash_view.dart';
import 'package:melomix/view/main_tabview/main_tabview.dart';
import 'package:melomix/view/register/RegisterScreen.dart';
import 'package:melomix/view/forgot_password/PasswordRecoveryScreen.dart';
import 'package:melomix/view/confirm_sign_up/email_verification.dart';
import 'package:melomix/view/login/LoginScreen.dart';



// Define tus rutas
class AppRoutes {
  static const String splash = '/';
  static const String main = '/main';
  static const String register = '/register';
  static const String passwordRecovery = '/passwordRecovery';
  static const String emailVerification = '/emailVerification'; // Cambié a minúscula para consistencia
  static const String login ='/Login';
  static final List<GetPage> routes = [
    GetPage(
      name: splash,
      page: () => SplashView(),
    ),
    GetPage(
      name: main,
      page: () => MainTabView(),
    ),
    GetPage(
      name: register,
      page: () => RegisterScreen(),
    ),
    GetPage(
      name: passwordRecovery,
      page: () => PasswordRecoveryScreen(),
    ),
    GetPage(
      name: emailVerification, // Usa el nombre consistente aquí
      page: () => EmailVerificationScreen(
        email: Get.parameters['email'] ?? '', // Recupera el argumento de email desde GetX
      ),
    ),
     GetPage(
      name: login,
      page: () => LoginScreen(),
    ),

  ];
}
