import 'package:flutter/material.dart';

import '../common/color_extension.dart';

// Widget personalizado que muestra una fila con un ícono y un texto.
// Cuando se toca la fila, se ejecuta una función proporcionada por el usuario.
class IconTextRow extends StatelessWidget {
  // Título que se mostrará al lado del ícono.
  final String title;

  // Ruta del ícono que se mostrará en la fila.
  final String icon;

  // Función que se ejecutará cuando se toque la fila.
  final VoidCallback onTap;

  // Constructor que recibe el título, la ruta del ícono y la función onTap.
  const IconTextRow({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Construye el widget
    return Column(
      mainAxisSize: MainAxisSize.min, // Ajusta el tamaño de la columna al contenido
      children: [
        SizedBox(
          height: 44, // Altura fija para el ListTile
          child: ListTile(
            leading: Image.asset(
              icon, // Carga el ícono desde la ruta proporcionada
              width: 25,
              height: 25,
              fit: BoxFit.contain, // Ajusta el tamaño del ícono para que se ajuste al contenedor
            ),
            title: Text(
              title, // Muestra el título proporcionado
              style: TextStyle(
                color: TColor.primaryText.withOpacity(0.9), // Color del texto con opacidad
                fontSize: 14, // Tamaño de fuente del texto
                fontWeight: FontWeight.w600, // Peso de fuente del texto
              ),
            ),
            onTap: onTap, // Ejecuta la función proporcionada cuando se toca la fila
          ),
        ),
        Divider(
          color: TColor.primaryText.withOpacity(0.07), // Color del divisor con opacidad
          indent: 70, // Margen izquierdo del divisor
        ),
      ],
    );
  }
}
