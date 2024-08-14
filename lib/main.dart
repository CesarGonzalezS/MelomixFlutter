// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:melomix/audio_helpers/page_manager.dart';
import 'package:melomix/audio_helpers/service_locator.dart';
import 'package:melomix/common/color_extension.dart';
import 'package:melomix/routes.dart';
import 'package:melomix/presentation/cubits/user_cubit.dart';
import 'package:melomix/presentation/cubits/artist_cubit.dart'; // Importa el ArtistCubit
import 'package:melomix/services/api_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserCubit(apiServices: ApiServices()), // Proveedor del cubit de usuario
        ),
        BlocProvider(
          create: (context) => ArtistCubit(artistServices: ApiServices()), // Proveedor del cubit de artista
        ),
      ],
      child: GetMaterialApp(
        title: 'MelomiMix',
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