import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/albums.dart'; 

abstract class AlbumState extends Equatable {
  @override
  List<Object> get props => [];
}

class AlbumInitial extends AlbumState {}

class AlbumLoading extends AlbumState {}

class AlbumSuccess extends AlbumState {
  final List<Album> albums;

  AlbumSuccess({required this.albums});

  @override
  List<Object> get props => [albums];
}

class AlbumError extends AlbumState {
  final String message;

  AlbumError({required this.message});

  @override
  List<Object> get props => [message];
}

// Cubit para manejar la lógica relacionada con Albums
class AlbumCubit extends Cubit<AlbumState> {
  AlbumCubit() : super(AlbumInitial());

  // Método para cargar los datos de albums
  Future<void> loadAlbums() async {
    emit(AlbumLoading());

    try {
      // Lógica para obtener los datos de la base de datos o API
      List<Album> albums = []; // Aquí iría la lógica para obtener los datos

      emit(AlbumSuccess(albums: albums));
    } catch (e) {
      emit(AlbumError(message: 'Failed to load albums: $e'));
    }
  }
}
