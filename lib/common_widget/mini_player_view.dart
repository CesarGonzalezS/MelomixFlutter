import 'dart:ui' as ui;

import 'package:audio_service/audio_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:melomix/audio_helpers/page_manager.dart';
import 'package:melomix/audio_helpers/service_locator.dart';
import 'package:melomix/common/color_extension.dart';
import 'package:melomix/common_widget/control_buttons.dart';
import 'package:melomix/view/main_player/main_player_view.dart';


// Vista del reproductor miniatura, que muestra información del archivo de audio actual.
class MiniPlayerView extends StatefulWidget {
  // Instancia única de MiniPlayerView para implementar el patrón Singleton.
  static const MiniPlayerView _instance = MiniPlayerView._internal();

  // Fábrica que devuelve la instancia única de MiniPlayerView.
  factory MiniPlayerView() {
    return _instance;
  }

  // Constructor privado para crear la instancia única.
  const MiniPlayerView._internal();

  @override
  State<MiniPlayerView> createState() => _MiniPlayerViewState();
}

class _MiniPlayerViewState extends State<MiniPlayerView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>(); // Obtiene la instancia del PageManager desde el contenedor de servicios

    return ValueListenableBuilder<AudioProcessingState>(
      valueListenable: pageManager.playbackStatNotifier, // Notificador para el estado de reproducción
      builder: (context, processingState, __) {
        // Si el estado de reproducción es inactivo, no muestra nada
        if (processingState == AudioProcessingState.idle) {
          return const SizedBox();
        }

        return ValueListenableBuilder<MediaItem?>(
            valueListenable: pageManager.currentSongNotifier, // Notificador para el ítem de medios actual
            builder: (context, mediaItem, __) {
              // Si no hay ítem de medios actual, no muestra nada
              if (mediaItem == null) return const SizedBox();

              return Dismissible(
                key: const Key('mini_player'),
                direction: DismissDirection.down, // Permite deslizar hacia abajo para descartar
                onDismissed: (direction) {
                  Feedback.forLongPress(context); // Proporciona retroalimentación al usuario
                  pageManager.stop(); // Detiene la reproducción
                },
                child: Dismissible(
                  key: Key(mediaItem.id), // Clave única basada en el ID del ítem de medios
                  confirmDismiss: (direction) {
                    // Maneja la confirmación de deslizamiento
                    if (direction == DismissDirection.startToEnd) {
                      pageManager.previous(); // Reproduce la canción anterior si se desliza hacia la derecha
                    } else {
                      pageManager.next(); // Reproduce la siguiente canción si se desliza hacia la izquierda
                    }
                    return Future.value(false);
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(horizontal: 0.0), // Margen horizontal del Card
                    elevation: 0, // Sin sombra
                    color: Colors.black12, // Color de fondo del Card
                    child: SizedBox(
                      height: 77.0, // Altura fija del Card
                      child: ClipRect(
                        child: BackdropFilter(
                          filter: ui.ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0), // Aplica un desenfoque de fondo
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ValueListenableBuilder<ProgressBarState>(
                                valueListenable: pageManager.progressNotifier, // Notificador para el progreso de la reproducción
                                builder: (context, value, __) {
                                  final position = value.current; // Posición actual de reproducción
                                  final totalDuration = value.total; // Duración total del ítem

                                  return position == null
                                      ? const SizedBox()
                                      : (position.inSeconds.toDouble() < 0.0 ||
                                      (position.inSeconds.toDouble() >
                                          totalDuration.inSeconds
                                              .toDouble()))
                                      ? const SizedBox()
                                      : SliderTheme(
                                    data: SliderThemeData(
                                        activeTrackColor: TColor.focus,
                                        inactiveTrackColor:
                                        Colors.transparent,
                                        trackHeight: 3,
                                        thumbColor: TColor.focus,
                                        thumbShape:
                                        const RoundSliderOverlayShape(
                                            overlayRadius: 1.5),
                                        overlayColor:
                                        Colors.transparent,
                                        overlayShape:
                                        const RoundSliderOverlayShape(
                                            overlayRadius: 1.0)),
                                    child: Center(
                                      child: Slider(
                                          inactiveColor:
                                          Colors.transparent,
                                          value: position.inSeconds
                                              .toDouble(),
                                          max: totalDuration.inSeconds
                                              .toDouble(),
                                          onChanged: (newPosition) {
                                            pageManager.seek(
                                              Duration(
                                                seconds:
                                                newPosition.round(),
                                              ),
                                            );
                                          }),
                                    ),
                                  );
                                },
                              ),
                              ListTile(
                                dense: false,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      opaque: false,
                                      pageBuilder: (_, ___, __) =>
                                      const MainPlayerView(), // Navega a la vista principal del reproductor
                                    ),
                                  );
                                },
                                title: Text(
                                  mediaItem.title, // Muestra el título del ítem de medios
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Text(
                                  mediaItem.artist ?? '', // Muestra el artista del ítem de medios
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                leading: Hero(
                                  tag: 'currentArtWork', // Etiqueta para la animación de transición
                                  child: Card(
                                    elevation: 0, // Sin sombra
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    clipBehavior: Clip.antiAlias,
                                    child: SizedBox.square(
                                      dimension: 40.0, // Tamaño del cuadrado del ícono
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(25),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                              mediaItem.artUri.toString(), // URL de la imagen del ítem de medios
                                              fit: BoxFit.cover,
                                              errorWidget: (context, url, error) {
                                                return Image.asset(
                                                  "assets/img/cover.jpg",
                                                  fit: BoxFit.cover,
                                                );
                                              },
                                              placeholder: (context, url) {
                                                return Image.asset(
                                                  "assets/img/cover.jpg",
                                                  fit: BoxFit.cover,
                                                );
                                              },
                                              width: 40,
                                              height: 40,
                                            ),
                                          ),
                                          Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: TColor.primaryText28),
                                              borderRadius:
                                              BorderRadius.circular(20),
                                            ),
                                          ),
                                          Container(
                                            width: 15,
                                            height: 15,
                                            decoration: BoxDecoration(
                                              color: TColor.bg,
                                              borderRadius:
                                              BorderRadius.circular(7.5),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                trailing: const ControlButtons(
                                  miniPlayer: true,
                                  buttons: ['Play/Pause', 'Next'], // Botones de control en el mini reproductor
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            });
      },
    );
  }
}
