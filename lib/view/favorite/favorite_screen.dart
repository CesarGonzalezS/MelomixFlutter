import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_favorites/presentation/cubits/favorite_cubit.dart';
import 'package:flutter_favorites/data/model/favorite_on_use.dart';

// Pantalla de favoritos
class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tus Favoritos'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showAddFavoriteModal(context);
            },
          ),
        ],
      ),
      body: BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context, state) {
          if (state is FavoriteLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is FavoriteSuccess) {
            if (state.favorites.isEmpty) {
              return Center(child: Text('No has agregado ningún favorito'));
            }
            return ListView.builder(
              itemCount: state.favorites.length,
              itemBuilder: (context, index) {
                final favorite = state.favorites[index];
                return ListTile(
                  title: Text(favorite.description ?? 'Sin descripción'),
                  subtitle: Text('Usuario ID: ${favorite.userId}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      context.read<FavoriteCubit>().deleteFavorite(favorite.favoriteId);
                    },
                  ),
                );
              },
            );
          } else if (state is FavoriteError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return Center(child: Text('No hay favoritos'));
          }
        },
      ),
    );
  }

  // Método para mostrar el modal para agregar favoritos
  void _showAddFavoriteModal(BuildContext context) {
    final _descriptionController = TextEditingController();

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Descripción'),
              ),
              SizedBox(height: 8.0),
              ElevatedButton(
                onPressed: () {
                  final newFavorite = Favorite(
                    favoriteId: DateTime.now().millisecondsSinceEpoch,
                    description: _descriptionController.text,
                    userId: 1, // Esto debe ser reemplazado por el id del usuario real
                    createdAt: DateTime.now(),
                  );
                  context.read<FavoriteCubit>().saveFavorite(newFavorite);
                  Navigator.pop(context);
                },
                child: Text('Agregar Favorito'),
              ),
            ],
          ),
        );
      },
    );
  }
}
