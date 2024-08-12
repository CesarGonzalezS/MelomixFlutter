// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:melomix/audio_helpers/page_manager.dart';
import 'package:melomix/audio_helpers/service_locator.dart';
import 'package:melomix/common/color_extension.dart';
import 'package:melomix/view/splash_view.dart';
import 'package:melomix/view/admin/song_crud_screen.dart';
import 'package:melomix/view/buscador/search_screen.dart'; // Importa SearchScreen

import 'package:melomix/routes.dart';
import 'package:melomix/presentation/cubits/user_cubit.dart'; // Importa tu cubit
import 'package:melomix/services/api_services.dart'; // Importa tu servicio de API

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit(apiServices: ApiServices()), // Proveedor del cubit
      child: GetMaterialApp(
        title: 'MelomiXXX',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "Circular Std",
          scaffoldBackgroundColor: TColor.bg,
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: TColor.primaryText,
                displayColor: TColor.primaryText,
              ),
          colorScheme: ColorScheme.fromSeed(seedColor: TColor.primary),
          useMaterial3: false,
        ),
        initialRoute: AppRoutes.splash, // Usa la ruta inicial definida
        getPages: AppRoutes.routes, // Usa las rutas definidas
      ),
    );
  }
}
