import 'package:bloc/bloc.dart';
import 'package:melomix/presentation/cubits/artistState.dart';

import '../../../data/model/artist.dart';
import '../../../services/api_services.dart';

class ArtistCubit extends Cubit<ArtistState> {
  final ApiServices apiServices;

  ArtistCubit({required this.apiServices}) : super(ArtistInitial());

  Future<void> createArtist(Artist artist) async {
    try {
      emit(ArtistLoading());
      await apiServices.createArtist(artist);
      List<Artist> updatedArtists = await apiServices.getAllArtists();
      emit(ArtistSuccess(artists: updatedArtists));
    } catch (e) {
      emit(ArtistError(message: e.toString()));
    }
  }

  Future<void> loadArtists() async {
    try {
      emit(ArtistLoading());
      List<Artist> artists = await apiServices.getAllArtists();
      emit(ArtistSuccess(artists: artists));
    } catch (e) {
      emit(ArtistError(message: e.toString()));
    }
  }

  Future<void> updateArtist(Artist artist) async {
    try {
      emit(ArtistLoading());
      await apiServices.updateArtist(artist);
      List<Artist> updatedArtists = await apiServices.getAllArtists();
      emit(ArtistSuccess(artists: updatedArtists));
    } catch (e) {
      emit(ArtistError(message: e.toString()));
    }
  }

  Future<void> deleteArtist(int artistId) async {
    try {
      emit(ArtistLoading());
      await apiServices.deleteArtist(artistId);
      List<Artist> updatedArtists = await apiServices.getAllArtists();
      emit(ArtistSuccess(artists: updatedArtists));
    } catch (e) {
      emit(ArtistError(message: e.toString()));
    }
  }
}