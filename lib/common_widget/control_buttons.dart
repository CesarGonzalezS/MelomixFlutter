import 'package:flutter/material.dart';
import 'package:melomix/audio_helpers/page_manager.dart';
import 'package:melomix/audio_helpers/service_locator.dart';
import 'package:melomix/common/color_extension.dart';


// Widget que muestra los botones de control para la reproducción de música.
class ControlButtons extends StatelessWidget {
  final bool shuffle; // Indica si el modo de reproducción aleatoria está activado
  final bool miniPlayer; // Indica si el botón se muestra en el mini reproductor
  final List<String> buttons; // Lista de botones a mostrar

  // Constructor que recibe las opciones para los botones de control
  const ControlButtons({
    super.key,
    this.shuffle = false,
    this.miniPlayer = false,
    this.buttons = const ['Previous', 'Play/Pause', 'Next'],
  });

  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>(); // Obtiene la instancia de PageManager desde el contenedor de servicios

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround, // Distribuye los botones con espacio alrededor
      mainAxisSize: MainAxisSize.min, // Ajusta el tamaño del Row al tamaño de sus hijos
      children: buttons.map((e) {
        switch (e) {
        // Botón para retroceder a la canción anterior
          case "Previous":
            return ValueListenableBuilder<bool>(
                valueListenable: pageManager.isFirstSongNotifier, // Notificador para verificar si es la primera canción
                builder: (context, isFirst, __) {
                  return IconButton(
                    onPressed: isFirst ? null : pageManager.previous, // Desactiva el botón si es la primera canción
                    icon: Image.asset(
                      "assets/img/previous_song.png", // Imagen del botón de retroceso
                      width: miniPlayer ? 20 : 50,
                      height: miniPlayer ? 20 : 50,
                    ),
                  );
                });

        // Botón de reproducción/pausa
          case 'Play/Pause':
            return SizedBox(
              width: miniPlayer ? 40 : 70, // Tamaño del botón según si está en el mini reproductor
              height: miniPlayer ? 40 : 70,
              child: ValueListenableBuilder<ButtonState>(
                valueListenable: pageManager.playButtonNotifier, // Notificador para el estado del botón de reproducción
                builder: (context, value, __) {
                  return Stack(
                    children: [
                      // Muestra un indicador de carga si el estado es 'loading'
                      if (value == ButtonState.loading)
                        Center(
                          child: SizedBox(
                            width: miniPlayer ? 40 : 70,
                            height: miniPlayer ? 40 : 70,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(TColor.primaryText),
                            ),
                          ),
                        ),
                      // Muestra el botón de reproducción o pausa según el estado
                      if (miniPlayer)
                        Center(
                          child: value == ButtonState.playing
                              ? IconButton(
                            onPressed: pageManager.pause,
                            icon: Icon(
                              Icons.pause_rounded,
                              color: TColor.primaryText,
                            ),
                          )
                              : IconButton(
                            onPressed: pageManager.play,
                            icon: Image.asset(
                              "assets/img/play.png",
                              width: 20,
                              height: 20,
                            ),
                          ),
                        )
                      else
                        Center(
                          child: value == ButtonState.playing
                              ? IconButton(
                            onPressed: pageManager.pause,
                            icon: Icon(
                              Icons.pause_rounded,
                              color: TColor.primaryText,
                              size: 50,
                            ),
                          )
                              : IconButton(
                            onPressed: pageManager.play,
                            icon: Image.asset(
                              "assets/img/play.png",
                              width: 50,
                              height: 50,
                            ),
                          ),
                        )
                    ],
                  );
                },
              ),
            );

        // Botón para avanzar a la siguiente canción
          case "Next":
            return ValueListenableBuilder<bool>(
                valueListenable: pageManager.isLastSongNotifier, // Notificador para verificar si es la última canción
                builder: (context, isLast, __) {
                  return IconButton(
                    onPressed: isLast ? null : pageManager.next, // Desactiva el botón si es la última canción
                    icon: Image.asset(
                      "assets/img/next_song.png", // Imagen del botón de avance
                      width: miniPlayer ? 20 : 50,
                      height: miniPlayer ? 20 : 50,
                    ),
                  );
                });

          default:
            return Container(); // Devuelve un contenedor vacío para cualquier opción de botón no reconocida
        }
      }).toList(),
    );
  }
}
