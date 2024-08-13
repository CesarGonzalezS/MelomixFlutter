// artist_screen.dart
import 'package:flutter/material.dart';

class ArtistScreen extends StatelessWidget {
  final List<String> artists = ['Artist 1', 'Artist 2', 'Artist 3']; // Lista de artistas de ejemplo

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Artists CRUD'),
      ),
      body: ListView.builder(
        itemCount: artists.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(artists[index]),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    // Lógica para editar el artista
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    // Lógica para eliminar el artista
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Lógica para añadir un nuevo artista
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
