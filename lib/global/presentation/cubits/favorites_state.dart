import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/favorites.dart'; 

abstract class FavoriteState extends Equatable {
  @override
  List<Object> get props => [];
}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteSuccess extends FavoriteState {
  final List<Favorite> favorites;

  FavoriteSuccess({required this.favorites});

  @override
  List<Object> get props => [favorites];
}

class FavoriteError extends FavoriteState {
  final String message;

  FavoriteError({required this.message});

  @override
  List<Object> get props => [message];
}

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial());

  // Método para cargar los datos de favorites
  Future<void> loadFavorites() async {
    emit(FavoriteLoading());

    try {
      // Lógica para obtener los datos de la base de datos o API
      List<Favorite> favorites = []; // Aquí iría la lógica para obtener los datos

      emit(FavoriteSuccess(favorites: favorites));
    } catch (e) {
      emit(FavoriteError(message: 'Failed to load favorites: $e'));
    }
  }
}
