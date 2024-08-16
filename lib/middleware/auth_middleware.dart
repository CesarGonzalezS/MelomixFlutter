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

    // Obtener preferencias de manera sincrónica
    SharedPreferences.getInstance().then((prefs) {
      String? userGroup = prefs.getString('user_group');

      if (userGroup == null || userGroup.isEmpty) {
        Get.snackbar('Acceso Denegado', 'Debes iniciar sesión para acceder a esta página.');
        return RouteSettings(name: AppRoutes.login);
      }

      if (userGroup == 'usuario' && adminRoutes.contains(route)) {
        Get.snackbar('Acceso Denegado', 'No tienes permiso para acceder a esta página.');
        return RouteSettings(name: AppRoutes.home);
      }

      if (userGroup == 'admin' && route == AppRoutes.homeadmin) {
        return null;  // Permitir la navegación a admin
      }

      return null;
    });

    return null;  // No realizar ninguna redirección por defecto.
  }
}
