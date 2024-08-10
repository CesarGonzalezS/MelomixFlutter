import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SongCrudScreen extends StatefulWidget {
  const SongCrudScreen({super.key});

  @override
  _SongCrudScreenState createState() => _SongCrudScreenState();
}

class _SongCrudScreenState extends State<SongCrudScreen> {
  final List<Song> songs = [];
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _albumIdController = TextEditingController();
  final TextEditingController _artistIdController = TextEditingController();
  final TextEditingController _genreController = TextEditingController();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _readSongs();
  }

  Future<void> _readSongs() async {
    final response = await http.get(Uri.parse('https://5zappruc5i.execute-api.us-east-2.amazonaws.com/Prod/read_song'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        songs.clear();
        songs.addAll(data.map((song) => Song.fromJson(song)).toList());
      });
    } else {
      throw Exception('Failed to load songs');
    }
  }

  Future<void> _createSong(Song song) async {
    final response = await http.post(
      Uri.parse('https://5zappruc5i.execute-api.us-east-2.amazonaws.com/Prod/create_song'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(song.toJson()),
    );

    if (response.statusCode == 200) {
      _readSongs();
    } else {
      throw Exception('Failed to create song');
    }
  }

  Future<void> _updateSong(Song song) async {
    final response = await http.put(
      Uri.parse('https://5zappruc5i.execute-api.us-east-2.amazonaws.com/Prod/update_song'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(song.toJson()),
    );

    if (response.statusCode == 200) {
      _readSongs();
    } else {
      throw Exception('Failed to update song');
    }
  }

  Future<void> _deleteSong(int songId) async {
    final response = await http.delete(
      Uri.parse('https://5zappruc5i.execute-api.us-east-2.amazonaws.com/Prod/delete_song'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'songId': songId}),
    );

    if (response.statusCode == 200) {
      _readSongs();
    } else {
      throw Exception('Failed to delete song');
    }
  }

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
                if (_titleController.text.isNotEmpty &&
                    _durationController.text.isNotEmpty &&
                    _artistIdController.text.isNotEmpty &&
                    _genreController.text.isNotEmpty) {
                  final newSong = Song(
                    songId: DateTime.now().millisecondsSinceEpoch,
                    title: _titleController.text,
                    duration: int.parse(_durationController.text),
                    albumId: _albumIdController.text.isNotEmpty
                        ? int.parse(_albumIdController.text)
                        : null,
                    artistId: int.parse(_artistIdController.text),
                    genre: _genreController.text,
                  );
                  _createSong(newSong);
                  _titleController.clear();
                  _durationController.clear();
                  _albumIdController.clear();
                  _artistIdController.clear();
                  _genreController.clear();
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

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
                final updatedSong = Song(
                  songId: songs[index].songId,
                  title: _titleController.text,
                  duration: int.parse(_durationController.text),
                  albumId: _albumIdController.text.isNotEmpty
                      ? int.parse(_albumIdController.text)
                      : null,
                  artistId: int.parse(_artistIdController.text),
                  genre: _genreController.text,
                );
                _updateSong(updatedSong);
                _titleController.clear();
                _durationController.clear();
                _albumIdController.clear();
                _artistIdController.clear();
                _genreController.clear();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteSongConfirmation(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Eliminar Canción'),
          content: const Text('¿Estás seguro de que deseas eliminar esta canción?'),
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
                _deleteSong(songs[index].songId);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _durationController.dispose();
    _albumIdController.dispose();
    _artistIdController.dispose();
    _genreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CRUD de Canciones'),
      ),
      body: ListView.builder(
        itemCount: songs.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(songs[index].title),
            subtitle: Text('Duración: ${songs[index].duration} segundos'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    _editSong(index);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    _deleteSongConfirmation(index);
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addSong,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Song {
  final int songId;
  final String title;
  final int duration;
  final int? albumId;
  final int artistId;
  final String genre;

  Song({
    required this.songId,
    required this.title,
    required this.duration,
    this.albumId,
    required this.artistId,
    required this.genre,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      songId: json['songId'],
      title: json['title'],
      duration: json['duration'],
      albumId: json['albumId'],
      artistId: json['artistId'],
      genre: json['genre'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'songId': songId,
      'title': title,
      'duration': duration,
      'albumId': albumId,
      'artistId': artistId,
      'genre': genre,
    };
  }
}
