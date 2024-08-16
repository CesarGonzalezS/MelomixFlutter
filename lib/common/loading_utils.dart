import 'package:flutter/material.dart';

import '../common/loading_indicator.dart'; // Asegúrate de importar el widget de carga

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, // Impide cerrar el diálogo al tocar fuera de él
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: LoadingIndicator(),
      );
    },
  );
}

void hideLoadingDialog(BuildContext context) {
  Navigator.of(context, rootNavigator: true).pop(); // Cierra el diálogo de carga
}
