import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:melomix/audio_helpers/audio_handler.dart';
import 'package:melomix/audio_helpers/service_locator.dart';

// Enum para representar los posibles estados del botón de reproducción
enum ButtonState {
  paused, // Estado cuando la reproducción está pausada
  playing, // Estado cuando la reproducción está en curso
  loading, // Estado cuando la reproducción está cargando
}

// Clase para notificar el estado del botón de reproducción
class PlayButtonNotifier extends ValueNotifier<ButtonState> {
  PlayButtonNotifier() : super(_initialValue);
  static const _initialValue = ButtonState.paused;
}

// Clase para representar el estado de la barra de progreso
class ProgressBarState {
  final Duration current; // Duración actual de la reproducción
  final Duration buffered; // Duración del contenido en buffer
  final Duration total; // Duración total del ítem

  ProgressBarState(
      {required this.current, required this.buffered, required this.total});
}

// Clase para notificar el estado de la barra de progreso
class ProgressNotifier extends ValueNotifier<ProgressBarState> {
  ProgressNotifier() : super(_initialValue);
  static final _initialValue = ProgressBarState(
    current: Duration.zero,
    buffered: Duration.zero,
    total: Duration.zero,
  );
}

// Enum para representar los posibles estados de repetición
enum RepeatState {
  off, // Repetición desactivada
  repeatSong, // Repetición de la canción actual
  repeatPlaylist, // Repetición de la lista de reproducción
}

// Clase para notificar el estado del botón de repetición
class RepeatButtonNotifier extends ValueNotifier<RepeatState> {
  RepeatButtonNotifier() : super(_initialValue);

  static const _initialValue = RepeatState.off;

  // Cambia al siguiente estado de repetición
  void nextState() {
    final next = (value.index + 1) % RepeatState.values.length;
    value = RepeatState.values[next];
  }
}

// Clase principal para gestionar la reproducción de medios
class PageManager {
  final currentSongNotifier = ValueNotifier<MediaItem?>(null); // Notificador para la canción actual
  final playbackStatNotifier =
  ValueNotifier<AudioProcessingState>(AudioProcessingState.idle); // Notificador para el estado de reproducción
  final playlistNotifier = ValueNotifier<List<MediaItem>>([]); // Notificador para la lista de reproducción
  final progressNotifier = ProgressNotifier(); // Notificador para el progreso de la barra
  final repeatButtonNotifier = RepeatButtonNotifier(); // Notificador para el estado de repetición
  final playButtonNotifier = PlayButtonNotifier(); // Notificador para el estado del botón de reproducción
  final isFirstSongNotifier = ValueNotifier<bool>(true); // Notificador para si la canción actual es la primera
  final isLastSongNotifier = ValueNotifier<bool>(true); // Notificador para si la canción actual es la última
  final isShuffleModeEnabledNotifier = ValueNotifier<bool>(false); // Notificador para el estado del modo aleatorio

  final audioHandler = getIt<AudioHandler>(); // Obteniendo el manejador de audio

  // Inicializa el PageManager y configura los escuchadores
  void init() async {
    listenToChangeInPlaylist();
    listenToPlayBackState();
    listenToCurrentPosition();
    listenToBufferedPosition();
    listenToTotalPosition();
    listenToChangesInSong();
  }

  // Escucha los cambios en la lista de reproducción
  void listenToChangeInPlaylist() {
    audioHandler.queue.listen((playlist) {
      if (playlist.isEmpty) {
        playlistNotifier.value = [];
        currentSongNotifier.value = null;
      } else {
        playlistNotifier.value = playlist;
      }
      updateSkipButton(); // Actualiza el botón de salto
    });
  }

  // Actualiza el estado de los botones de salto (anterior/siguiente)
  void updateSkipButton() {
    final mediaItem = audioHandler.mediaItem.value;
    final playlist = audioHandler.queue.value;
    if (playlist.length < 2 || mediaItem == null) {
      isFirstSongNotifier.value = true;
      isLastSongNotifier.value = true;
    } else {
      isFirstSongNotifier.value = playlist.first == mediaItem;
      isLastSongNotifier.value = playlist.last == mediaItem;
    }
  }

  // Escucha los cambios en el estado de reproducción
  void listenToPlayBackState() {
    audioHandler.playbackState.listen((playbackState) {
      final isPlaying = playbackState.playing;
      final processingState = playbackState.processingState;
      playbackStatNotifier.value = processingState;
      if (processingState == AudioProcessingState.loading ||
          processingState == AudioProcessingState.buffering) {
        playButtonNotifier.value = ButtonState.loading;
      } else if (!isPlaying) {
        playButtonNotifier.value = ButtonState.paused;
      } else if (processingState != AudioProcessingState.completed) {
        playButtonNotifier.value = ButtonState.playing;
      } else {
        audioHandler.seek(Duration.zero);
        audioHandler.pause();
      }
    });
  }

  // Escucha la posición actual de la reproducción
  void listenToCurrentPosition() {
    AudioService.position.listen((position) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
          current: position,
          buffered: oldState.buffered,
          total: oldState.total);
    });
  }

  // Escucha la posición del contenido en buffer
  void listenToBufferedPosition() {
    audioHandler.playbackState.listen((playbackState) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
          current: oldState.current,
          buffered: playbackState.bufferedPosition,
          total: oldState.total);
    });
  }

  // Escucha la duración total del ítem de medios
  void listenToTotalPosition() {
    audioHandler.mediaItem.listen((mediaItem) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
          current: oldState.current,
          buffered: oldState.buffered,
          total: mediaItem?.duration ?? Duration.zero);
    });
  }

  // Escucha los cambios en la canción actual
  void listenToChangesInSong() {
    audioHandler.mediaItem.listen((mediaItem) {
      currentSongNotifier.value = mediaItem;
      updateSkipButton(); // Actualiza el botón de salto
    });
  }

  // Reproduce el ítem actual
  void play() => audioHandler.play();

  // Pausa la reproducción
  void pause() => audioHandler.pause();

  // Salta a una posición específica en la reproducción
  void seek(Duration position) => audioHandler.seek(position);

  // Salta al ítem anterior en la lista de reproducción
  void previous() => audioHandler.skipToPrevious();

  // Salta al siguiente ítem en la lista de reproducción
  void next() => audioHandler.skipToNext();

  // Reproduce el ítem actual como una tarea asincrónica
  Future<void> playAS() async {
    return await audioHandler.play();
  }

  // Actualiza la cola de reproducción con una nueva lista de ítems
  Future<void> updateQueue(List<MediaItem> queue) async {
    return await audioHandler.updateQueue(queue);
  }

  // Actualiza el ítem de medios actual
  Future<void> updateMediaItem(MediaItem mediaItem) async {
    return await audioHandler.updateMediaItem(mediaItem);
  }

  // Mueve un ítem de la cola a una nueva posición
  Future<void> moveMediaItem(int currentIndex, int newIndex) async {
    return await (audioHandler as AudioPlayerHandler)
        .moveQueueItem(currentIndex, newIndex);
  }

  // Elimina un ítem de la cola en una posición específica
  Future<void> removeQueueItemAt(int index) async {
    return await (audioHandler as AudioPlayerHandler)
        .removeQueueItemIndex(index);
  }

  // Ejecuta una acción personalizada en el manejador de audio
  Future<void> customAction(String name) async {
    return await audioHandler.customAction(name);
  }

  // Salta a un ítem en la cola de reproducción
  Future<void> skipToQueueItem(int index) async {
    return await audioHandler.skipToQueueItem(index);
  }

  // Cambia el estado de repetición
  void repeat() {
    repeatButtonNotifier.nextState();
    final repeatMode = repeatButtonNotifier.value;
    switch (repeatMode) {
      case RepeatState.off:
        audioHandler.setRepeatMode(AudioServiceRepeatMode.none);
        break;
      case RepeatState.repeatSong:
        audioHandler.setRepeatMode(AudioServiceRepeatMode.one);
        break;
      case RepeatState.repeatPlaylist:
        audioHandler.setRepeatMode(AudioServiceRepeatMode.all);
        break;
    }
  }

  // Configura el modo de repetición
  Future<void> setRepeatMode(AudioServiceRepeatMode repeatMode) async {
    switch (repeatMode) {
      case AudioServiceRepeatMode.none:
        repeatButtonNotifier.value = RepeatState.off;
        break;
      case AudioServiceRepeatMode.one:
        repeatButtonNotifier.value = RepeatState.repeatSong;
        break;
      case AudioServiceRepeatMode.group:
        break;
      case AudioServiceRepeatMode.all:
        repeatButtonNotifier.value = RepeatState.repeatPlaylist;
        break;
    }
    audioHandler.setRepeatMode(repeatMode);
  }

  // Activa o desactiva el modo aleatorio
  void shuffle() async {
    final enable = !isShuffleModeEnabledNotifier.value;
    isShuffleModeEnabledNotifier.value = enable;
    if (enable) {
      audioHandler.setShuffleMode(AudioServiceShuffleMode.all);
    } else {
      audioHandler.setShuffleMode(AudioServiceShuffleMode.none);
    }
  }

  // Configura el modo aleatorio
  Future<void> setShuffleMode(AudioServiceShuffleMode value) async {
    isShuffleModeEnabledNotifier.value = value == AudioServiceShuffleMode.all;
    return audioHandler.setShuffleMode(value);
  }

  // Agrega un ítem a la cola de reproducción
  Future<void> add(MediaItem mediaItem) async {
    audioHandler.addQueueItem(mediaItem);
  }

  // Agrega una lista de ítems a la cola de reproducción en una posición específica
  Future<void> adds(List<MediaItem> mediaItems, int index) async {

    if(mediaItems.isEmpty) {
      return;
    }
    await (audioHandler as MyAudioHandler).setNewPlaylist(mediaItems, index);
  }

  // Elimina el último ítem de la cola de reproducción
  void remove(){
    final lastIndex = audioHandler.queue.value.length - 1;
    if(lastIndex < 0) return;
    audioHandler.removeQueueItemAt(lastIndex);
  }

  // Elimina todos los ítems de la cola de reproducción
  Future<void> removeAll() async {
    final lastIndex = audioHandler.queue.value.length - 1;
    if (lastIndex < 0) return;
    audioHandler.removeQueueItemAt(lastIndex);
  }

  // Libera recursos y realiza una acción de limpieza
  void dispose(){
    audioHandler.customAction('dispose');
  }

  // Detiene la reproducción y limpia la cola de reproducción
  Future<void> stop() async {
    await audioHandler.stop();
    await audioHandler.seek(Duration.zero);
    currentSongNotifier.value = null;
    await removeAll();
    await Future.delayed(const Duration(milliseconds: 300));
  }

}
