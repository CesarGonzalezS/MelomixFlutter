import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melomix/presentation/cubits/song_cubit.dart';
import 'package:melomix/data/model/song_model.dart';

class EditSongScreen extends StatefulWidget {
  final Song song;

  EditSongScreen({required this.song});

  @override
  _EditSongScreenState createState() => _EditSongScreenState();
}

class _EditSongScreenState extends State<EditSongScreen> {
  late TextEditingController _titleController;
  late TextEditingController _durationController;
  late TextEditingController _artistIdController;
  late TextEditingController _genreController;
  late TextEditingController _albumIdController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.song.title);
    _durationController = TextEditingController(text: widget.song.duration);
    _artistIdController = TextEditingController(text: widget.song.artistId.toString());
    _genreController = TextEditingController(text: widget.song.genre);
    _albumIdController = TextEditingController(text: widget.song.albumId?.toString() ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _durationController.dispose();
    _artistIdController.dispose();
    _genreController.dispose();
    _albumIdController.dispose();
    super.dispose();
  }

  void _updateSong() {
    final title = _titleController.text;
    final duration = _durationController.text;
    final artistId = int.tryParse(_artistIdController.text) ?? 0;
    final genre = _genreController.text;
    final albumId = int.tryParse(_albumIdController.text);

    final updatedSong = Song(
      songId: widget.song.songId, // Mantén el ID actual para actualizar
      title: title,
      duration: duration,
      artistId: artistId,
      genre: genre,
      albumId: albumId,
    );

    context.read<SongCubit>().updateSong(updatedSong).then((_) {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Song'),
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
              decoration: InputDecoration(labelText: 'Duration'),
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
              onPressed: _updateSong,
              child: Text('Update Song'),
            ),
          ],
        ),
      ),
    );
  }
}
