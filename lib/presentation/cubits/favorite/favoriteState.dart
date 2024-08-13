import 'package:equatable/equatable.dart';
import 'package:melomix/data/model/favorites.dart';

abstract class FavoriteState extends Equatable{
  @override
  List<Object?> get props => [];
}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState{}

class FavoriteSuccess extends FavoriteState{
  final List<Favorite> favorites;

  FavoriteSuccess({required this.favorites});

  @override
  List<Object?> get props => [favorites];
}

class FavoriteError extends FavoriteState{
  final String message;

  FavoriteError({required this.message});

  @override
  List<Object?> get props => [message];
}