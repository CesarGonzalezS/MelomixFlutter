import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melomix/presentation/cubits/song_cubit.dart';
import 'package:melomix/presentation/cubits/song_state.dart';
import 'package:melomix/data/model/song_model.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    context.read<SongCubit>().getAllSongs();
  }

  void _updateSearchQuery(String query) {
    setState(() {
      _searchQuery = query.toLowerCase();
    });
  }

  List<Song> _filterSongs(List<Song> songs) {
    return songs
        .where((song) => song.title.toLowerCase().contains(_searchQuery))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Container(
          decoration: BoxDecoration(
            color: Colors.grey[850],
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            onChanged: _updateSearchQuery,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
              hintText: 'Search songs...',
              hintStyle: TextStyle(color: Colors.grey[400]),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 15),
            ),
          ),
        ),
      ),
      body: BlocBuilder<SongCubit, SongState>(
        builder: (context, state) {
          if (state is SongLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          } else if (state is SongSuccess) {
            final filteredSongs = _filterSongs(state.songs);
            return ListView.builder(
              itemCount: filteredSongs.length,
              itemBuilder: (context, index) {
                final song = filteredSongs[index];
                return Card(
                  color: Colors.grey[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.symmetric(
                      vertical: 5, horizontal: 10),
                  child: ListTile(
                    leading: const Icon(Icons.music_note,
                        color: Colors.white),
                    title: Text(
                      song.title,
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      'Genre: ${song.genre} | Duration: ${song.duration} seconds',
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                    onTap: () {
                      // Acción al tocar la canción
                    },
                  ),
                );
              },
            );
          } else if (state is SongError) {
            return Center(
              child: Text(
                'Failed to load songs: ${state.message}',
                style: const TextStyle(color: Colors.white),
              ),
            );
          }
          return const Center(
            child: Text(
              'No songs available.',
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      ),
    );
  }
}
