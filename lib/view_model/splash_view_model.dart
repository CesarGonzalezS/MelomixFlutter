import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:melomix/view/main_tabview/main_tabview.dart';
// Controlador de estado para la pantalla de bienvenida (Splash View).
// Utiliza GetX para la gestión del estado y la navegación.
class SplashViewMode extends GetxController {

  // Clave global para el Scaffold, utilizada para controlar el Drawer.
  var scaffoldKey = GlobalKey<ScaffoldState>();

  // Método para cargar la vista de manera asíncrona.
  // Espera 3 segundos antes de navegar a la vista principal (MainTabView).
  void loadView() async {
    await Future.delayed(const Duration(seconds: 3));
    Get.to(() => const MainTabView());
  }

  // Método para abrir el Drawer del Scaffold.
  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  // Método para cerrar el Drawer del Scaffold.
  void closeDrawer() {
    scaffoldKey.currentState?.closeDrawer();
  }
}
