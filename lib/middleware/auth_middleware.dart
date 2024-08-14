import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:melomix/routes.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final prefsFuture = SharedPreferences.getInstance().then((prefs) {
      String? userGroup = prefs.getString('user_group');

      // Rutas que deben estar restringidas solo para administradores
      final adminRoutes = [
        AppRoutes.admin,
        AppRoutes.albums,
        AppRoutes.artists,
        AppRoutes.songs,
        AppRoutes.adminCrud,
        AppRoutes.favorites,
      ];

      // Si el user_group es 'usuario' y el usuario intenta acceder a alguna de las rutas de administración
      if (userGroup == 'usuario' && adminRoutes.contains(route)) {
        // Mostramos un mensaje de acceso denegado y redirigimos al home
        Get.snackbar('Acceso Denegado', 'No tienes permiso para acceder a esta página.');
        Get.offAllNamed(AppRoutes.home); // Redirige al home
        return RouteSettings(name: AppRoutes.home);
      }

      // Si el user_group es 'admin', se permite la navegación a rutas de admin
      if (userGroup == 'admin' && adminRoutes.contains(route)) {
        return null; // Permite la navegación
      }

      return null; // Permite la navegación por defecto si no hay restricciones
    });

    // Debemos devolver la redirección inmediatamente, por lo que devolvemos null mientras tanto
    return null;
  }
}
