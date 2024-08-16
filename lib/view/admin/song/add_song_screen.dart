import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melomix/data/model/song_model.dart';
import 'package:melomix/presentation/cubits/song_cubit.dart';

class AddSongScreen extends StatefulWidget {
  @override
  _AddSongScreenState createState() => _AddSongScreenState();
}

class _AddSongScreenState extends State<AddSongScreen> {
  final _titleController = TextEditingController();
  final _durationController = TextEditingController();
  final _artistIdController = TextEditingController();
  final _genreController = TextEditingController();
  final _albumIdController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _durationController.dispose();
    _artistIdController.dispose();
    _genreController.dispose();
    _albumIdController.dispose();
    super.dispose();
  }

  void _saveSong() {
    final title = _titleController.text;
    final duration = int.tryParse(_durationController.text) ?? 0; // Convertimos String a int
    final artistId = int.tryParse(_artistIdController.text) ?? 0;
    final genre = _genreController.text;
    final albumId = int.tryParse(_albumIdController.text);

    final song = Song(
      title: title,
      duration: duration, // Ahora es un int
      artistId: artistId,
      genre: genre,
      albumId: albumId,
    );

    context.read<SongCubit>().createSong(song).then((_) {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Song'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _durationController,
              decoration: InputDecoration(labelText: 'Duration (seconds)'), // Indicamos que es en segundos
              keyboardType: TextInputType.number, // Solo números
            ),
            TextField(
              controller: _artistIdController,
              decoration: InputDecoration(labelText: 'Artist ID'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _albumIdController,
              decoration: InputDecoration(labelText: 'Album ID'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _genreController,
              decoration: InputDecoration(labelText: 'Genre'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveSong,
              child: Text('Save Song'),
            ),
          ],
        ),
      ),
    );
  }
}
