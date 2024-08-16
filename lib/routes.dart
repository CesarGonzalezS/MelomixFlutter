import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:melomix/view/splash_view.dart';
import 'package:melomix/view/register/RegisterScreen.dart';
import 'package:melomix/view/forgot_password/PasswordRecoveryScreen.dart';
import 'package:melomix/view/confirm_sign_up/email_verification.dart';
import 'package:melomix/view/login/LoginScreen.dart';
import 'package:melomix/view/admin/home_Admin.dart';
import 'package:melomix/view/admin/album_screen.dart';
import 'package:melomix/view/admin/artist_screen.dart';
import 'package:melomix/view/admin/song/songs_screen.dart';
import 'package:melomix/view/admin/admin_screen.dart';
import 'package:melomix/view/admin/favorites_screen.dart';
import 'package:melomix/view/home/home_view.dart';
import 'package:melomix/middleware/auth_middleware.dart';
import 'package:melomix/view/search/search_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String home = '/home';
  static const String main = '/main';
  static const String register = '/register';
  static const String passwordRecovery = '/passwordRecovery';
  static const String emailVerification = '/emailVerification';
  static const String login = '/login';
  static const String search = '/search';
  static const String homeadmin = '/homeadmin';
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
      name: home,
      page: () => HomeView(),
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
      name: search,
      page: () => SearchScreen(),
    ),




    GetPage(
      name: AppRoutes.homeadmin,
      page: () => HomeAdmin(),
      middlewares: [AuthMiddleware()], // Aplicar middleware aquí
    ),
    GetPage(
      name: AppRoutes.albums,
      page: () => AlbumScreen(),
      middlewares: [AuthMiddleware()], // Aplicar middleware aquí

    ),
    GetPage(
      name: AppRoutes.artists,
      page: () => ArtistScreen(),
      middlewares: [AuthMiddleware()], // Aplicar middleware aquí

    ),
    GetPage(
      name: AppRoutes.songs,
      page: () => SongsScreen(),
      middlewares: [AuthMiddleware()], // Aplicar middleware aquí

    ),
    GetPage(
      name: AppRoutes.adminCrud,
      page: () => AdminScreen(),
      middlewares: [AuthMiddleware()], // Aplicar middleware aquí
    ),
    GetPage(
      name: AppRoutes.favorites,
      page: () => FavoritesScreen(),
      middlewares: [AuthMiddleware()], // Aplicar middleware aquí

    ),
  ];
}
