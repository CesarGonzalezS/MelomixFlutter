import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melomix/services/api_services.dart';
import 'package:melomix/presentation/cubits/song_cubit.dart';
import 'package:melomix/presentation/cubits/song_state.dart';
import 'package:melomix/data/model/song_model.dart';

class SongsScreen extends StatefulWidget {
  @override
  _SongsScreenState createState() => _SongsScreenState();
}

class _SongsScreenState extends State<SongsScreen> {
  final _titleController = TextEditingController();
  final _durationController = TextEditingController();
  final _albumIdController = TextEditingController();
  final _artistIdController = TextEditingController();
  final _genreController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<SongCubit>().getAllSongs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,  // Fondo negro
      appBar: AppBar(
        title: const Text('Songs'),
        backgroundColor: Colors.grey[900],  // Color oscuro para AppBar
      ),
      body: BlocBuilder<SongCubit, SongState>(
        builder: (context, state) {
          if (state is SongLoading) {
            return const Center(child: CircularProgressIndicator(color: Colors.white));
          } else if (state is SongSuccess) {
            return ListView.builder(
              itemCount: state.songs.length,
              itemBuilder: (context, index) {
                final song = state.songs[index];
                return Card(
                  color: Colors.grey[850],  // Color oscuro para las tarjetas
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: const Icon(Icons.music_note, color: Colors.white),  // Ícono de música
                    title: Text(
                      song.title,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Genre: ${song.genre} | Duration: ${song.duration} seconds',
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.redAccent),  // Ícono de eliminación en rojo
                      onPressed: () => _confirmDelete(song.songId!),
                    ),
                    onTap: () {
                      _titleController.text = song.title;
                      _durationController.text = song.duration.toString(); // Convertimos int a String
                      _albumIdController.text = song.albumId?.toString() ?? '';
                      _artistIdController.text = song.artistId.toString();
                      _genreController.text = song.genre;

                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          backgroundColor: Colors.grey[900],  // Fondo oscuro en el diálogo
                          title: const Text('Edit Song', style: TextStyle(color: Colors.white)),
                          content: _buildSongForm(),
                          actions: [
                            TextButton(
                              onPressed: () {
                                final updatedSong = Song(
                                  songId: song.songId,
                                  title: _titleController.text,
                                  duration: int.parse(_durationController.text), // Convertimos String a int
                                  albumId: _albumIdController.text.isEmpty
                                      ? null
                                      : int.tryParse(_albumIdController.text),
                                  artistId: int.parse(_artistIdController.text),
                                  genre: _genreController.text,
                                );
                                context.read<SongCubit>().updateSong(updatedSong);
                                Navigator.of(context).pop();
                              },
                              child: const Text('Update', style: TextStyle(color: Colors.white)),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('Cancel', style: TextStyle(color: Colors.redAccent)),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            );
          } else if (state is SongError) {
            return Center(child: Text('Failed to load songs: ${state.message}', style: const TextStyle(color: Colors.white)));
          }
          return const Center(child: Text('No songs available.', style: TextStyle(color: Colors.white)));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _clearForm();
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: Colors.grey[900],  // Fondo oscuro en el diálogo
              title: const Text('Create Song', style: TextStyle(color: Colors.white)),
              content: _buildSongForm(),
              actions: [
                TextButton(
                  onPressed: () {
                    final newSong = Song(
                      title: _titleController.text,
                      duration: int.parse(_durationController.text), 
                      albumId: _albumIdController.text.isEmpty
                          ? null
                          : int.tryParse(_albumIdController.text),
                      artistId: int.parse(_artistIdController.text),
                      genre: _genreController.text,
                    );
                    context.read<SongCubit>().createSong(newSong);
                    Navigator.of(context).pop();
                  },
                  child: const Text('Create', style: TextStyle(color: Colors.white)),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel', style: TextStyle(color: Colors.redAccent)),
                ),
              ],
            ),
          );
        },
        backgroundColor: Colors.grey[850],
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildSongForm() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: _titleController,
          decoration: const InputDecoration(
            labelText: 'Title',
            labelStyle: TextStyle(color: Colors.white),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
          style: const TextStyle(color: Colors.white),
        ),
        TextFormField(
          controller: _durationController,
          decoration: const InputDecoration(
            labelText: 'Duration (seconds)',
            labelStyle: TextStyle(color: Colors.white),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
          keyboardType: TextInputType.number,
          style: const TextStyle(color: Colors.white),
        ),
        TextField(
          controller: _albumIdController,
          decoration: const InputDecoration(
            labelText: 'Album ID (Optional)',
            labelStyle: TextStyle(color: Colors.white),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
          keyboardType: TextInputType.number,
          style: const TextStyle(color: Colors.white),
        ),
        TextField(
          controller: _artistIdController,
          decoration: const InputDecoration(
            labelText: 'Artist ID',
            labelStyle: TextStyle(color: Colors.white),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
          keyboardType: TextInputType.number,
          style: const TextStyle(color: Colors.white),
        ),
        TextField(
          controller: _genreController,
          decoration: const InputDecoration(
            labelText: 'Genre',
            labelStyle: TextStyle(color: Colors.white),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  void _clearForm() {
    _titleController.clear();
    _durationController.clear();
    _albumIdController.clear();
    _artistIdController.clear();
    _genreController.clear();
  }

  void _confirmDelete(int songId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],  // Fondo oscuro en el diálogo
        title: const Text('Delete Song', style: TextStyle(color: Colors.white)),
        content: const Text('Are you sure you want to delete this song?', style: TextStyle(color: Colors.white)),
        actions: [
          TextButton(
            onPressed: () {
              context.read<SongCubit>().deleteSong(songId);
              Navigator.of(context).pop();
            },
            child: const Text('Delete', style: TextStyle(color: Colors.redAccent)),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
