import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/songs.dart';

abstract class SongState extends Equatable {
  @override
  List<Object> get props => [];
}

class SongInitial extends SongState {}

class SongLoading extends SongState {}

class SongSuccess extends SongState {
  final List<Song> songs;

  SongSuccess({required this.songs});

  @override
  List<Object> get props => [songs];
}

class SongError extends SongState {
  final String message;

  SongError({required this.message});

  @override
  List<Object> get props => [message];
}

class SongCubit extends Cubit<SongState> {
  SongCubit() : super(SongInitial());

  // Método para cargar los datos de songs
  Future<void> loadSongs() async {
    emit(SongLoading());

    try {
      // Lógica para obtener los datos de la base de datos o API
      List<Song> songs = []; // Aquí iría la lógica para obtener los datos

      emit(SongSuccess(songs: songs));
    } catch (e) {
      emit(SongError(message: 'Failed to load songs: $e'));
    }
  }
}
