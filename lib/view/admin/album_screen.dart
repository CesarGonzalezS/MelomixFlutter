import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melomix/presentation/cubits/album/albumCubit.dart';
import 'package:melomix/presentation/cubits/album/albumState.dart';
import '../../services/api_services.dart';

class AlbumScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AlbumCubit(apiServices: ApiServices()),
      child: AlbumsFavoritesPage(),
    );
  }
}

class AlbumsFavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<AlbumCubit>().loadAlbums(); // Load albums on init

    return Scaffold(
      appBar: AppBar(title: Text('Tus Álbumes Favoritos')),
      body: BlocBuilder<AlbumCubit, AlbumState>(
        builder: (context, state) {
          if (state is AlbumLoading) {
            return CircularProgressIndicator();
          } else if (state is AlbumSuccess) {
            return ListView.builder(
              itemCount: state.albums.length + 1, // +1 for the add button
              itemBuilder: (context, index) {
                if (index == state.albums.length) {
                  return ListTile(
                    leading: Icon(Icons.add),
                    title: Text('Agregar Nuevo Álbum'),
                    onTap: () => _addNewAlbum(context),
                  );
                }
                return ListTile(
                  title: Text(state.albums[index].title),
                  subtitle: Text('Release Date: ${state.albums[index].releaseDate.toIso8601String()}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _confirmDelete(context, state.albums[index].albumId),
                  ),
                );
              },
            );
          } else if (state is AlbumError) {
            return Text('Error: ${state.message}');
          }
          return Text('Unexpected state');
        },
      ),
    );
  }

  void _addNewAlbum(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirmar'),
        content: Text('¿Estás seguro de querer agregar un nuevo álbum?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Sí'),
          ),
        ],
      ),
    );

    if (result == true) {
// Aquí agregar lógica para añadir un nuevo álbum
// Ejemplo: context.read<AlbumCubit>().addAlbum(newAlbum);
    }
  }

  void _confirmDelete(BuildContext context, int albumId) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirmar'),
        content: Text('¿Estás seguro de querer eliminar este álbum?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No'),
          ),
          TextButton(
            onPressed: () {
              context.read<AlbumCubit>().deleteAlbum(albumId);
              Navigator.of(context).pop(true);
            },
            child: Text('Sí'),
          ),
        ],
      ),
    );
  }
}
