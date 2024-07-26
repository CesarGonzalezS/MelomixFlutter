import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:melomix/audio_helpers/page_manager.dart';
import 'package:melomix/audio_helpers/service_locator.dart';
import 'package:melomix/common/color_extension.dart';
import 'package:melomix/view/splash_view.dart';

// Punto de entrada principal de la aplicación.
void main() async {
  // Asegura que la inicialización de Flutter esté completada antes de hacer cualquier otra cosa.
  WidgetsFlutterBinding.ensureInitialized();

  // Configura el Service Locator para la inyección de dependencias.
  await setupServiceLocator();

  // Lanza la aplicación principal.
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();

    // Inicializa el PageManager al inicio de la aplicación.
    getIt<PageManager>().init();
  }

  @override
  void dispose() {
    // Limpia los recursos y disposables cuando el widget es destruido.
    super.dispose();
    getIt<PageManager>().dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'MelonMix', // Título de la aplicación.
      debugShowCheckedModeBanner: false, // Oculta el banner de depuración.

      // Define el tema de la aplicación.
      theme: ThemeData(
        fontFamily: "Circular Std", // Establece la fuente de la aplicación.
        scaffoldBackgroundColor: Colors.black, // Color de fondo del scaffold.
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: TColor.primaryText, // Color del texto del cuerpo.
          displayColor: TColor.primaryText, // Color del texto de la pantalla.
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: TColor.primary, // Color base para el esquema de colores.
        ),
        useMaterial3: false, // Desactiva el uso de Material Design 3.
      ),

      // Define la vista inicial de la aplicación.
      home: const SplashView(),
    );
  }
}
