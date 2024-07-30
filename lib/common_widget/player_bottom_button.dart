import 'package:flutter/material.dart';
import '../common/color_extension.dart';

// Widget que representa un botón en la parte inferior del reproductor.
class PlayerBottomButton extends StatelessWidget {
  final String title; // Título del botón, que se mostrará debajo del icono
  final String icon; // Ruta del icono que se mostrará en el botón
  final VoidCallback onPressed; // Función que se ejecutará al presionar el botón

  // Constructor que recibe los parámetros necesarios para crear el botón
  const PlayerBottomButton({
    super.key,
    required this.title,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0), // Espaciado alrededor del botón
      child: Column(
        children: [
          SizedBox(
            width: 40, // Ancho del botón
            height: 40, // Alto del botón
            child: IconButton(
              onPressed: onPressed, // Acción a realizar al presionar el botón
              icon: Image.asset(
                icon, // Ruta del icono del botón
                width: 30, // Ancho del icono
                height: 30, // Alto del icono
                color: TColor.primaryText80, // Color del icono
              ),
            ),
          ),
          Text(
            title, // Texto que se muestra debajo del icono
            style: TextStyle(
              color: TColor.secondaryText, // Color del texto
              fontSize: 8, // Tamaño de la fuente del texto
            ),
          ),
        ],
      ),
    );
  }
}
