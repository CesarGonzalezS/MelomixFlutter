import 'dart:async';
import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:melomix/audio_helpers/mediaitem_converter.dart';
import 'package:melomix/audio_helpers/page_manager.dart';
import 'package:melomix/audio_helpers/service_locator.dart';

// Variable para almacenar el tiempo del último toque del reproductor
DateTime playerTapTime = DateTime.now();

// Getter para verificar si el proceso de reproducción debe iniciarse
bool get isProcessForPlay {
  return DateTime.now().difference(playerTapTime).inMilliseconds > 600;
}

Timer? debounce;

// Función para manejar el proceso de reproducción con debounce
void playerPlayProcessDebounce(List songsList, int index) {
  debounce?.cancel(); // Cancela el temporizador anterior
  debounce = Timer(const Duration(milliseconds: 600), () {
    PlayerInvoke.init(songsList: songsList, index: index); // Inicia la reproducción
  });
}

// Clase para gestionar la invocación del reproductor
class PlayerInvoke {
  static final pageManager = getIt<PageManager>(); // Obtiene el PageManager

  // Inicializa la reproducción con la lista de canciones y el índice
  static Future<void> init({
    required List songsList,
    required int index,
    bool fromMiniPlayer = false,
    bool shuffle = false,
    String? playlistBox,
  }) async {
    final int globalIndex = index < 0 ? 0 : index;
    final List finalList = songsList.toList();
    if (shuffle) finalList.shuffle(); // Baraja la lista si es necesario

    if (!fromMiniPlayer) {
      if (!Platform.isAndroid) {
        await pageManager.stop(); // Detiene la reproducción si no es Android
      }
      setValues(finalList, globalIndex); // Configura los valores para la reproducción
    }
  }

  // Configura la cola de reproducción y el ítem actual
  static Future<void> setValues(List arr, int index,
      {recommend = false}) async {
    final List<MediaItem> queue = [];
    final Map playItem = arr[index] as Map;
    final Map? nextItem =
    index == arr.length - 1 ? null : arr[index + 1] as Map;

    // Convierte los ítems de la lista a MediaItem
    queue.addAll(
      arr.map(
            (song) =>
            MediaItemConverter.mapToMediaItem(song as Map, autoplay: recommend),
      ),
    );
    updateNPlay(queue, index); // Actualiza la cola y reproduce
  }

  // Actualiza la cola de reproducción y comienza a reproducir
  static Future<void> updateNPlay(List<MediaItem> queue, int index) async {
    try {
      await pageManager.setShuffleMode(AudioServiceShuffleMode.none); // Desactiva el modo aleatorio
      await pageManager.adds(queue, index); // Añade los ítems a la cola
      await pageManager.playAS(); // Comienza la reproducción
    } catch (e) {
      print("error: $e"); // Manejo de errores
    }
  }
}
