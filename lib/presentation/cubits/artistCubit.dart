import 'package:bloc/bloc.dart';
import 'package:melomix/data/model/artist.dart';
import 'package:melomix/services/api_services.dart';
import 'artistState.dart';

class ArtistCubit extends Cubit<ArtistState> {
  final ApiServices artistServices;

  ArtistCubit({required this.artistServices}) : super(ArtistInitial());

  // Método para crear un nuevo artista
  Future<void> createArtist(Artist artist) async {
    try {
      emit(ArtistLoading());
      await artistServices.createArtist(artist);
      List<Artist> updatedArtists = await artistServices.getAllArtists();
      emit(ArtistSuccess(artists: updatedArtists));
    } catch (e) {
      emit(ArtistError(message: e.toString()));
    }
  }

  // Método para obtener todos los artistas
  Future<void> loadArtists() async {
    try {
      emit(ArtistLoading());
      List<Artist> artists = await artistServices.getAllArtists();
      emit(ArtistSuccess(artists: artists));
    } catch (e) {
      emit(ArtistError(message: e.toString()));
    }
  }

  // Método para actualizar un artista
  Future<void> updateArtist(Artist artist) async {
    try {
      emit(ArtistLoading());
      await artistServices.updateArtist(artist);
      List<Artist> updatedArtists = await artistServices.getAllArtists();
      emit(ArtistSuccess(artists: updatedArtists));
    } catch (e) {
      emit(ArtistError(message: e.toString()));
    }
  }

  // Método para eliminar un artista
  Future<void> deleteArtist(int artistId) async {
    try {
      emit(ArtistLoading());
      await artistServices.deleteArtist(artistId);
      List<Artist> updatedArtists = await artistServices.getAllArtists();
      emit(ArtistSuccess(artists: updatedArtists));
    } catch (e) {
      emit(ArtistError(message: e.toString()));
    }
  }
}