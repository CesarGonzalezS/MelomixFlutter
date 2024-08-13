import 'package:melomix/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melomix/services/api_services.dart';
import 'package:melomix/presentation/cubits/song_cubit.dart';
import 'package:melomix/presentation/cubits/song_state.dart';
import 'package:melomix/data/model/song_model.dart';

class SongsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SongCubit(apiServices: ApiServices()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Songs'),
        ),
        body: BlocBuilder<SongCubit, SongState>(
          builder: (context, state) {
            if (state is SongLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is SongSuccess) {
              final songs = state.songs;
              return ListView.builder(
                itemCount: songs.length,
                itemBuilder: (context, index) {
                  final song = songs[index];
                  return ListTile(
                    title: Text(song.title),
                    subtitle: Text(song.duration),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        // Navigate to song edit screen
                      },
                    ),
                  );
                },
              );
            } else if (state is SongError) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return Center(child: Text('No songs available'));
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddSongScreen(),
              ),
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

class AddSongScreen extends StatefulWidget {
  @override
  _AddSongScreenState createState() => _AddSongScreenState();
}

class _AddSongScreenState extends State<AddSongScreen> {
  final _titleController = TextEditingController();
  final _durationController = TextEditingController();
  final _artistIdController = TextEditingController();
  final _genreController = TextEditingController();
  final _albumIdController = TextEditingController(); // Agregado

  void _saveSong() {
    final title = _titleController.text;
    final duration = _durationController.text;
    final artistId = int.tryParse(_artistIdController.text) ?? 0;
    final genre = _genreController.text;
    final albumId = int.tryParse(_albumIdController.text) ?? 0; // Agregado

    final song = Song(
      title: title,
      duration: duration,
      artistId: artistId,
      genre: genre,
      albumId: albumId, // Agregado
    );

    context.read<SongCubit>().createSong(song);
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
              decoration: InputDecoration(labelText: 'Duration'),
            ),
            TextField(
              controller: _artistIdController,
              decoration: InputDecoration(labelText: 'Artist ID'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _albumIdController, // Agregado
              decoration: InputDecoration(labelText: 'Album ID'), // Agregado
              keyboardType: TextInputType.number, // Agregado
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
