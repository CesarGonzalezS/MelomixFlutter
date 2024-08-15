import 'package:bloc/bloc.dart';
import 'package:melomix/presentation/cubits/album/albumState.dart';

import '../../../data/model/albums.dart';
import '../../../services/api_services.dart';

class AlbumCubit extends Cubit<AlbumState> {
  final ApiServices apiServices;

  AlbumCubit({required this.apiServices}) : super(AlbumInitial());

  Future<void> createAlbum(Album album) async {
    try {
      emit(AlbumLoading());
      await apiServices.createAlbum(album);
      List<Album> updatedAlbums = await apiServices.getAllAlbums();
      emit(AlbumSuccess(albums: updatedAlbums));
    } catch (e) {
      emit(AlbumError(message: e.toString()));
    }
  }

  Future<void> loadAlbums() async {
    try {
      emit(AlbumLoading());
      List<Album> albums = await apiServices.getAllAlbums();
      emit(AlbumSuccess(albums: albums));
    } catch (e) {
      emit(AlbumError(message: e.toString()));
    }
  }

  Future<void> updateAlbum(Album album) async {
    try {
      emit(AlbumLoading());
      await apiServices.updateAlbum(album);
      List<Album> updatedAlbums = await apiServices.getAllAlbums();
      emit(AlbumSuccess(albums: updatedAlbums));
    } catch (e) {
      emit(AlbumError(message: e.toString()));
    }
  }

  Future<void> deleteAlbum(int albumId) async {
    try {
      emit(AlbumLoading());
      await apiServices.deleteAlbum(albumId);
      List<Album> updatedAlbums = await apiServices.getAllAlbums();
      emit(AlbumSuccess(albums: updatedAlbums));
    } catch (e) {
      emit(AlbumError(message: e.toString()));
    }
  }
}
