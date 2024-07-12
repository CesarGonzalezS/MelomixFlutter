import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/favorite_on_use.dart';

abstract class FavoriteOnUseState extends Equatable {
  @override
  List<Object> get props => [];
}

class FavoriteOnUseInitial extends FavoriteOnUseState {}

class FavoriteOnUseLoading extends FavoriteOnUseState {}

class FavoriteOnUseSuccess extends FavoriteOnUseState {
  final List<FavoriteOnUse> favoriteOnUses;

  FavoriteOnUseSuccess({required this.favoriteOnUses});

  @override
  List<Object> get props => [favoriteOnUses];
}

class FavoriteOnUseError extends FavoriteOnUseState {
  final String message;

  FavoriteOnUseError({required this.message});

  @override
  List<Object> get props => [message];
}

class FavoriteOnUseCubit extends Cubit<FavoriteOnUseState> {
  FavoriteOnUseCubit() : super(FavoriteOnUseInitial());

  // Método para cargar los datos de favorite_on_use
  Future<void> loadFavoriteOnUse() async {
    emit(FavoriteOnUseLoading());

    try {
      // Lógica para obtener los datos de la base de datos o API
      List<FavoriteOnUse> favoriteOnUses = []; // Aquí iría la lógica para obtener los datos

      emit(FavoriteOnUseSuccess(favoriteOnUses: favoriteOnUses));
    } catch (e) {
      emit(FavoriteOnUseError(message: 'Failed to load favorite_on_use: $e'));
    }
  }
}
