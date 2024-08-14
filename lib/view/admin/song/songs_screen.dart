import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melomix/services/api_services.dart';
import 'package:melomix/presentation/cubits/song_cubit.dart';
import 'package:melomix/presentation/cubits/song_state.dart';
import 'package:melomix/data/model/song_model.dart';
import 'package:melomix/view/admin/song/add_song_screen.dart';
import 'package:melomix/view/admin/song/edit_song_screen.dart';
import 'package:melomix/view/admin/song/delete_song_screen.dart';

class SongsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SongCubit(apiServices: ApiServices())..getAllSongs(),
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
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: [
                      DataColumn(label: Text('Title')),
                      DataColumn(label: Text('Duration')),
                      DataColumn(label: Text('Genre')),
                      DataColumn(label: Text('Artist ID')),
                      DataColumn(label: Text('Album ID')),
                      DataColumn(label: Text('Actions')),
                    ],
                    rows: songs.map((song) {
                      return DataRow(cells: [
                        DataCell(Text(song.title)),
                        DataCell(Text(song.duration.toString())),
                        DataCell(Text(song.genre)),
                        DataCell(Text(song.artistId.toString())),
                        DataCell(Text(song.albumId.toString())),
                        DataCell(Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditSongScreen(song: song),
                                  ),
                                );
                              },
                            ),
                            // Eliminado el botón de eliminar aquí
                          ],
                        )),
                      ]);
                    }).toList(),
                  ),
                ),
              );
            } else if (state is SongError) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return Center(child: Text('No songs available'));
            }
          },
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddSongScreen(),
                  ),
                );
              },
              child: Icon(Icons.add),
              heroTag: null,
            ),
            SizedBox(height: 16),
            FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DeleteSongScreen(),
                  ),
                );
              },
              child: Icon(Icons.delete),
              heroTag: null,
            ),
          ],
        ),
      ),
    );
  }
}
