import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:melomix/audio_helpers/page_manager.dart';
import 'package:melomix/audio_helpers/service_locator.dart';
import 'package:melomix/common/color_extension.dart';
import 'package:melomix/routes.dart';
import 'package:melomix/presentation/cubits/user_cubit.dart';
import 'package:melomix/presentation/cubits/song_cubit.dart'; // Importa SongCubit
import 'package:melomix/presentation/cubits/artistCubit.dart'; // Importa el ArtistCubit
import 'package:melomix/services/api_services.dart';
import 'package:melomix/services/storage_service.dart'; // Importa tu StorageService

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();

  // Inicializa StorageService
  await StorageService().init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserCubit>(
          create: (context) => UserCubit(apiServices: ApiServices()),
        ),
        BlocProvider<SongCubit>(
          create: (context) => SongCubit(apiServices: ApiServices()),
        ),
        BlocProvider<ArtistCubit>(
          create: (context) => ArtistCubit(apiServices: ApiServices()),
        ),
        // Agrega más providers si es necesario
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
        initialRoute: AppRoutes.splash,
        getPages: AppRoutes.routes,
        navigatorKey: Get.key, // Para manejar la navegación con GetX
      ),
    );
  }
}
