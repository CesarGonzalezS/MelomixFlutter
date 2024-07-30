import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:melomix/view_model/splash_view_model.dart';

// Widget que representa la pantalla de bienvenida (Splash Screen) de la aplicación.
class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  // Instancia del ViewModel para la pantalla de bienvenida, gestionada por GetX.
  final splashVM = Get.put(SplashViewMode());

  @override
  void initState() {
    super.initState();

    // Configura el modo de interfaz del sistema para mostrar solo el contenido de la aplicación.
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);

    // Llama al método para cargar datos o inicializar procesos necesarios.
    splashVM.loadView();
  }

  @override
  Widget build(BuildContext context) {
    // Obtiene las dimensiones del dispositivo a través de MediaQuery.
    var media = MediaQuery.sizeOf(context);

    return Scaffold(
      body: Center(
        // Muestra el logo de la aplicación en el centro de la pantalla.
        child: Image.asset(
          "assets/img/logomelomix.jpg",
          width: media.width * 0.10, // Establece el ancho del logo como el 30% del ancho de la pantalla.
        ),
      ),
    );
  }
}
