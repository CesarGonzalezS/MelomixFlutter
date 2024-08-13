import 'package:bloc/bloc.dart';
import 'package:melomix/data/model/songs_model.dart';

import 'package:melomix/services/api_services.dart';
import 'package:melomix/presentation/cubits/song_state.dart';

class SongCubit extends Cubit<SongState> {
  final ApiServices apiServices;

  SongCubit({required this.apiServices}) : super(SongInitial());

  Future<void> createSong(Song song) async {
    try {
      emit(SongLoading());
      await apiServices.createSong(song);
      final songs = await apiServices.getAllSongs(); // Asumiendo que tienes un método para obtener todas las canciones
      emit(SongSuccess(songs: songs));
    } catch (e) {
      emit(SongError(message: e.toString()));
    }
  }

  Future<void> readSongs() async {
    try {
      emit(SongLoading());
      final songs = await apiServices.getAllSongs(); // Asumiendo que tienes un método para obtener todas las canciones
      emit(SongSuccess(songs: songs));
    } catch (e) {
      emit(SongError(message: e.toString()));
    }
  }

  Future<void> updateSong(Song song) async {
    try {
      emit(SongLoading());
      await apiServices.updateSong(song);
      final songs = await apiServices.getAllSongs(); // Asumiendo que tienes un método para obtener todas las canciones
      emit(SongSuccess(songs: songs));
    } catch (e) {
      emit(SongError(message: e.toString()));
    }
  }

  Future<void> deleteSong(int songId) async {
    try {
      emit(SongLoading());
      await apiServices.deleteSong(songId);
      final songs = await apiServices.getAllSongs(); // Asumiendo que tienes un método para obtener todas las canciones
      emit(SongSuccess(songs: songs));
    } catch (e) {
      emit(SongError(message: e.toString()));
    }
  }
}
