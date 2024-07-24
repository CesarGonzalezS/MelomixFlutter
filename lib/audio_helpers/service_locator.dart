import 'package:audio_service/audio_service.dart';
import 'package:get_it/get_it.dart';
import 'package:melomix/audio_helpers/audio_handler.dart';
import 'package:melomix/audio_helpers/page_manager.dart';

// Instancia de GetIt para la gestión de dependencias
GetIt getIt = GetIt.instance;

// Configura el localizador de servicios
Future<void> setupServiceLocator() async {
   // Registra una instancia singleton de AudioHandler en el localizador de servicios
   getIt.registerSingleton<AudioHandler>(await initAudioService());

   // Registra una instancia lazy singleton de PageManager en el localizador de servicios
   getIt.registerLazySingleton<PageManager>(() => PageManager());
}
