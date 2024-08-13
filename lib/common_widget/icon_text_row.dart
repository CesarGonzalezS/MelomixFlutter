import 'package:flutter/material.dart';

class IconTextRow extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback onTap;
  final bool isExpanded;

  const IconTextRow({
    required this.title,
    required this.icon,
    required this.onTap,
    this.isExpanded = false, // Añade isExpanded con un valor por defecto
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Image.asset(icon, width: 30, height: 30),
          if (isExpanded) // Mostrar título si isExpanded es true
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                title,
                style: TextStyle(color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}
