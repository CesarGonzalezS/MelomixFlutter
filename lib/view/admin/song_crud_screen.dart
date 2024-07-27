import 'package:flutter/material.dart';

class SongCrudScreen extends StatefulWidget {
  const SongCrudScreen({super.key});

  @override
  _SongCrudScreenState createState() => _SongCrudScreenState();
}

class _SongCrudScreenState extends State<SongCrudScreen> {
  final List<Song> songs = [];
  final List<FavoriteItem> favorites = [];
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _albumIdController = TextEditingController();
  final TextEditingController _artistIdController = TextEditingController();
  final TextEditingController _genreController = TextEditingController();
  int _currentIndex = 0;

  // Función para agregar una nueva canción
  void _addSong() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Agregar Canción'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Título',
                  labelStyle: TextStyle(color: Colors.black),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(color: Colors.black),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _durationController,
                decoration: InputDecoration(
                  labelText: 'Duración',
                  labelStyle: TextStyle(color: Colors.black),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.black),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _albumIdController,
                decoration: InputDecoration(
                  labelText: 'ID del Álbum (opcional)',
                  labelStyle: TextStyle(color: Colors.black),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.black),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _artistIdController,
                decoration: InputDecoration(
                  labelText: 'ID del Artista',
                  labelStyle: TextStyle(color: Colors.black),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.black),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _genreController,
                decoration: InputDecoration(
                  labelText: 'Género',
                  labelStyle: TextStyle(color: Colors.black),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Agregar'),
              onPressed: () {
                setState(() {
                  if (_titleController.text.isNotEmpty &&
                      _durationController.text.isNotEmpty &&
                      _artistIdController.text.isNotEmpty &&
                      _genreController.text.isNotEmpty) {
                    songs.add(Song(
                      songId: DateTime.now().millisecondsSinceEpoch,
                      title: _titleController.text,
                      duration: int.parse(_durationController.text),
                      albumId: _albumIdController.text.isNotEmpty
                          ? int.parse(_albumIdController.text)
                          : null,
                      artistId: int.parse(_artistIdController.text),
                      genre: _genreController.text,
                    ));
                    _titleController.clear();
                    _durationController.clear();
                    _albumIdController.clear();
                    _artistIdController.clear();
                    _genreController.clear();
                  }
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Función para editar una canción existente
  void _editSong(int index) {
    _titleController.text = songs[index].title;
    _durationController.text = songs[index].duration.toString();
    _albumIdController.text = songs[index].albumId?.toString() ?? '';
    _artistIdController.text = songs[index].artistId.toString();
    _genreController.text = songs[index].genre;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Editar Canción'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Título',
                  labelStyle: TextStyle(color: Colors.black),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(color: Colors.black),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _durationController,
                decoration: InputDecoration(
                  labelText: 'Duración',
                  labelStyle: TextStyle(color: Colors.black),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.black),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _albumIdController,
                decoration: InputDecoration(
                  labelText: 'ID del Álbum (opcional)',
                  labelStyle: TextStyle(color: Colors.black),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.black),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _artistIdController,
                decoration: InputDecoration(
                  labelText: 'ID del Artista',
                  labelStyle: TextStyle(color: Colors.black),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.black),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _genreController,
                decoration: InputDecoration(
                  labelText: 'Género',
                  labelStyle: TextStyle(color: Colors.black),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Guardar'),
              onPressed: () {
                setState(() {
                  songs[index] = Song(
                    songId: songs[index].songId,
                    title: _titleController.text,
                    duration: int.parse(_durationController.text),
                    albumId: _albumIdController.text.isNotEmpty
                        ? int.parse(_albumIdController.text)
                        : null,
                    artistId: int.parse(_artistIdController.text),
                    genre: _genreController.text,
                  );
                  _titleController.clear();
                  _durationController.clear();
                  _albumIdController.clear();
                  _artistIdController.clear();
                  _genreController.clear();
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Función para eliminar una canción
  void _deleteSong(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar Eliminación'),
          content: const Text('¿Estás seguro de que quieres eliminar la canción?'),
          actions: [
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Eliminar'),
              onPressed: () {
                setState(() {
                  songs.removeAt(index);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Función para construir la lista de canciones
  Widget _buildSongsList() {
    return Row(
      children: [
        const Spacer(),
        Expanded(
          flex: 8,
          child: ListView.builder(
            itemCount: songs.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: Key(songs[index].title),
                onDismissed: (direction) {
                  setState(() {
                    songs.removeAt(index);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${songs[index].title} eliminado')),
                  );
                },
                background: Container(color: Colors.red),
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(songs[index].title[0]),
                  ),
                  title: Text(songs[index].title),
                  subtitle: Text('${songs[index].duration} segundos'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _editSong(index),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _deleteSong(index),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const Spacer(),
      ],
    );
  }

  // Función para construir la lista de favoritos
  Widget _buildFavoritesList() {
    return ListView.builder(
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(favorites[index].imageUrl),
          ),
          title: Text(favorites[index].title),
          subtitle: Text(favorites[index].subtitle),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MelomiXXX'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addSong,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      _currentIndex = 0;
                    });
                  },
                  child: const Text('Canciones'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _currentIndex = 1;
                    });
                  },
                  child: const Text('Favoritos'),
                ),
              ],
            ),
          ),
          Expanded(
            child: _currentIndex == 0 ? _buildSongsList() : _buildFavoritesList(),
          ),
        ],
      ),
    );
  }
}

class Song {
  int songId;
  String title;
  int duration;
  int? albumId;
  int artistId;
  String genre;

  Song({
    required this.songId,
    required this.title,
    required this.duration,
    this.albumId,
    required this.artistId,
    required this.genre,
  });
}

class FavoriteItem {
  final String title;
  final String subtitle;
  final String imageUrl;

  const FavoriteItem(this.title, this.subtitle, this.imageUrl);
}
