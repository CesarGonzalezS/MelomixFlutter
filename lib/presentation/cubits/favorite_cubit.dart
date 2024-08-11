import 'package:bloc/bloc.dart';
import 'package:flutter_favorites/data/repository/favorite_on_use.dart';
import 'package:flutter_favorites/data/model/favorite_on_use.dart';

// Definir los diferentes estados que puede tener la UI
abstract class FavoriteState {}
class FavoriteInitial extends FavoriteState {}
class FavoriteLoading extends FavoriteState {}
class FavoriteSuccess extends FavoriteState {
  final List<Favorite> favorites;
  FavoriteSuccess({required this.favorites});
}
class FavoriteError extends FavoriteState {
  final String message;
  FavoriteError({required this.message});
}

// Cubit para manejar los favoritos
class FavoriteCubit extends Cubit<FavoriteState> {
  final FavoriteRepository favoriteRepository;

  FavoriteCubit({required this.favoriteRepository}) : super(FavoriteInitial());

  // Método para obtener los favoritos
  Future<void> getFavorites() async {
    try {
      emit(FavoriteLoading());
      final favorites = await favoriteRepository.getFavorites();
      emit(FavoriteSuccess(favorites: favorites));
    } catch (e) {
      emit(FavoriteError(message: e.toString()));
    }
  }

  // Método para guardar un favorito
  Future<void> saveFavorite(Favorite favorite) async {
    try {
      emit(FavoriteLoading());
      await favoriteRepository.saveFavorite(favorite);
      getFavorites();
    } catch (e) {
      emit(FavoriteError(message: e.toString()));
    }
  }

  // Método para actualizar un favorito
  Future<void> updateFavorite(Favorite favorite) async {
    try {
      emit(FavoriteLoading());
      await favoriteRepository.updateFavorite(favorite);
      getFavorites();
    } catch (e) {
      emit(FavoriteError(message: e.toString()));
    }
  }

  // Método para eliminar un favorito
  Future<void> deleteFavorite(int id) async {
    try {
      emit(FavoriteLoading());
      await favoriteRepository.deleteFavorite(id);
      getFavorites();
    } catch (e) {
      emit(FavoriteError(message: e.toString()));
    }
  }
}
