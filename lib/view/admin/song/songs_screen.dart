import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melomix/services/api_services.dart';
import 'package:melomix/presentation/cubits/song_cubit.dart';
import 'package:melomix/presentation/cubits/song_state.dart';
import 'package:melomix/data/model/song_model.dart';
import 'package:melomix/view/admin/song/add_song_screen.dart';
import 'package:melomix/view/admin/song/edit_song_screen.dart';
import 'package:melomix/view/admin/song/delete_song_screen.dart';
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
      appBar: AppBar(
        title: Text('Songs'),
      ),
      body: BlocBuilder<SongCubit, SongState>(
        builder: (context, state) {
          if (state is SongLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is SongSuccess) {
            return ListView.builder(
              itemCount: state.songs.length,
              itemBuilder: (context, index) {
                final song = state.songs[index];
                return ListTile(
                  title: Text(song.title),
                  subtitle: Text('Genre: ${song.genre} | Duration: ${song.duration}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      context.read<SongCubit>().deleteSong(song.songId!);
                    },
                  ),
                  onTap: () {
                    _titleController.text = song.title;
                    _durationController.text = song.duration;
                    _albumIdController.text = song.albumId?.toString() ?? '';
                    _artistIdController.text = song.artistId.toString();
                    _genreController.text = song.genre;

                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Edit Song'),
                        content: _buildSongForm(),
                        actions: [
                          TextButton(
                            onPressed: () {
                              final updatedSong = Song(
                                songId: song.songId,
                                title: _titleController.text,
                                duration: _durationController.text,
                                albumId: _albumIdController.text.isEmpty
                                    ? null
                                    : int.tryParse(_albumIdController.text),
                                artistId: int.parse(_artistIdController.text),
                                genre: _genreController.text,
                              );
                              context.read<SongCubit>().updateSong(updatedSong);
                              Navigator.of(context).pop();
                            },
                            child: Text('Update'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text('Cancel'),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          } else if (state is SongError) {
            return Center(child: Text('Failed to load songs: ${state.message}'));
          }
          return Center(child: Text('No songs available.'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _clearForm();
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Create Song'),
              content: _buildSongForm(),
              actions: [
                TextButton(
                  onPressed: () {
                    final newSong = Song(
                      title: _titleController.text,
                      duration: _durationController.text,
                      albumId: _albumIdController.text.isEmpty
                          ? null
                          : int.tryParse(_albumIdController.text),
                      artistId: int.parse(_artistIdController.text),
                      genre: _genreController.text,
                    );
                    context.read<SongCubit>().createSong(newSong);
                    Navigator.of(context).pop();
                  },
                  child: Text('Create'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Cancel'),
                ),
              ],
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildSongForm() {
    return Column(
      mainAxisSize: MainAxisSize.min,
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
          controller: _albumIdController,
          decoration: InputDecoration(labelText: 'Album ID (Optional)'),
          keyboardType: TextInputType.number,
        ),
        TextField(
          controller: _artistIdController,
          decoration: InputDecoration(labelText: 'Artist ID'),
          keyboardType: TextInputType.number,
        ),
        TextField(
          controller: _genreController,
          decoration: InputDecoration(labelText: 'Genre'),
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
}