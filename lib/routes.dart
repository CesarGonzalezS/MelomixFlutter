// routes.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:melomix/view/splash_view.dart';
import 'package:melomix/view/main_tabview/main_tabview.dart';
import 'package:melomix/view/register/RegisterScreen.dart';
import 'package:melomix/view/forgot_password/PasswordRecoveryScreen.dart';
import 'package:melomix/view/confirm_sign_up/email_verification.dart';
import 'package:melomix/view/login/LoginScreen.dart';
import 'package:melomix/view/admin/home_Admin.dart';
import 'package:melomix/view/admin/album_screen.dart';
import 'package:melomix/view/admin/artist_screen.dart';
import 'package:melomix/view/admin/songs_screen.dart';
import 'package:melomix/view/admin/admin_screen.dart';
import 'package:melomix/view/admin/favorites_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String main = '/main';
  static const String register = '/register';
  static const String passwordRecovery = '/passwordRecovery';
  static const String emailVerification = '/emailVerification';
  static const String login = '/login';
  static const String admin = '/admin';
  static const String albums = '/albums';
  static const String artists = '/artists';
  static const String songs = '/songs';
  static const String adminCrud = '/adminCrud';
  static const String favorites = '/favorites';

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
      name: emailVerification,
      page: () => EmailVerificationScreen(),
    ),
    GetPage(
      name: login,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: admin,
      page: () => HomeAdmin(),
    ),
    GetPage(
      name: albums,
      page: () => AlbumScreen(),
    ),
    GetPage(
      name: artists,
      page: () => ArtistScreen(),
    ),
    GetPage(
      name: songs,
      page: () => SongsScreen(),
    ),
    GetPage(
      name: adminCrud,
      page: () => AdminScreen(),
    ),
    GetPage(
      name: favorites,
      page: () => FavoritesScreen(),
    ),
  ];
}
