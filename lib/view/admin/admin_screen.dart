// admin_screen.dart
import 'package:flutter/material.dart';

class AdminScreen extends StatelessWidget {
  final List<String> admins = ['Admin 1', 'Admin 2', 'Admin 3']; // Lista de administradores de ejemplo

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin CRUD'),
      ),
      body: ListView.builder(
        itemCount: admins.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(admins[index]),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    // Lógica para editar el administrador
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    // Lógica para eliminar el administrador
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Lógica para añadir un nuevo administrador
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
