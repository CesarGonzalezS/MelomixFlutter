import 'package:bloc/bloc.dart';
import 'package:get/get.dart';
import 'package:melomix/data/model/favorites.dart';
import 'package:melomix/data/repository/favorite_repository.dart';
import 'package:melomix/services/api_services.dart';
import 'favoriteState.dart';

class FavoriteCubit extends Cubit<FavoriteState>{
  final FavoriteRepository favoriteRepository;

  FavoriteCubit({required this.favoriteRepository}) : super(FavoriteInitial());

  //We are gonna load the favorites from an user
  Future<void> loadFavorites(int userId) async {
    try{
      emit(FavoriteLoading());
      final favorites = await favoriteRepository.getAllFavoritesByUser(userId);
      emit(FavoriteSuccess(favorites : favorites));
    }catch(e){
       emit(FavoriteError(message: e.toString()));
    }
  }

  //We are gonna update an existing favorite
  Future<void> updateFavorite(Favorite favorite) async{
    try{
      emit(FavoriteLoading());
      await favoriteRepository.updateFavorite(favorite);
      loadFavorites(favorite.userId);
    }catch(e){
      emit(FavoriteError(message: e.toString()));
    }
  }

  //Finally, to elimiate a favorite
  Future<void> deleteFavorite(int favoriteId, int userId) async{
    try{
      emit(FavoriteLoading());
      await favoriteRepository.deleteFavorite(favoriteId);
      loadFavorites(userId);

    }catch(e){
      emit(FavoriteError(message:e.toString()));
    }
  }
}

