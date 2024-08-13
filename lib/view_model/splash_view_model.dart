import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Controlador de estado para la pantalla de bienvenida (Splash View).
// Utiliza GetX para la gestión del estado y la navegación.
class SplashViewMode extends GetxController {

  // Clave global para el Scaffold, utilizada para controlar el Drawer.
  var scaffoldKey = GlobalKey<ScaffoldState>();



  // Método para abrir el Drawer del Scaffold.
  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  // Método para cerrar el Drawer del Scaffold.
  void closeDrawer() {
    scaffoldKey.currentState?.closeDrawer();
  }
}
