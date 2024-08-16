import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:melomix/routes.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final adminRoutes = [
      AppRoutes.homeadmin,
      AppRoutes.albums,
      AppRoutes.artists,
      AppRoutes.songs,
      AppRoutes.adminCrud,
      AppRoutes.favorites,
    ];

    _checkUserPermissions(route, adminRoutes);
    return null; // Permitir la navegación por defecto mientras se verifica
  }

  void _checkUserPermissions(String? route, List<String> adminRoutes) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userGroup = prefs.getString('user_group');

    if (userGroup == null || userGroup.isEmpty) {
      Get.snackbar('Acceso Denegado', 'Debes iniciar sesión para acceder a esta página.');
      Get.offAllNamed(AppRoutes.login);
    } else if (userGroup == 'usuario' && adminRoutes.contains(route)) {
      Get.snackbar('Acceso Denegado', 'No tienes permiso para acceder a esta página.');
      Get.offAllNamed(AppRoutes.home);
    }
  }
}
