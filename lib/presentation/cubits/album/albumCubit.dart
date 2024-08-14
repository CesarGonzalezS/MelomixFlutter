import 'package:bloc/bloc.dart';
import 'package:melomix/data/model/albums.dart';
import 'package:melomix/data/repository/album_repository.dart';
import 'package:melomix/services/api_services.dart';
import 'albumState.dart';

class AlbumCubit extends Cubit<AlbumState> {
  final ApiServices apiServices;

  AlbumCubit({required this.apiServices, required AlbumRepository albumRepository}) : super(AlbumInitial());

  //Methods:
  //Creating a new Album
  Future<void> createAlbum(Album album) async{
    try{
      emit(AlbumLoading());
      await apiServices.createAlbum(album);
      List<Album> updatedAlbums = await apiServices.getAllAlbums();
      emit(AlbumSuccess(albums: updatedAlbums));
    } catch (e){
      emit(AlbumError(message: e.toString()));
    }

  }

  //Method to get all albums

  Future<void> loadAlbums() async{
    try{
      emit(AlbumLoading());
      List<Album> albums = await apiServices.getAllAlbums();
      emit(AlbumSuccess(albums: albums));
    } catch (e){
      emit(AlbumError(message: e.toString()));
    }
  }

  //Method to update albums
  Future<void> updateAlbum(Album album) async{
    try{
      emit(AlbumLoading());
      await apiServices.updateAlbum(album);
      List<Album> updatedAlbums = await apiServices.getAllAlbums();
      emit(AlbumSuccess(albums: updatedAlbums));
    }catch (e){
      emit(AlbumError(message: e.toString()));
    }
  }

  //Finally to delete an album
  Future<void> deleteAlbum(int albumId) async{
    try{
      emit(AlbumLoading());
      await apiServices.deleteAlbum(albumId);
      List<Album> updatedAlbums = await apiServices.getAllAlbums();
      emit(AlbumSuccess(albums: updatedAlbums));
    }catch (e){
      emit(AlbumError(message: e.toString()));
    }
  }
}