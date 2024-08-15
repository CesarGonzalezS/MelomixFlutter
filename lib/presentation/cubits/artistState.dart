import 'package:equatable/equatable.dart';
import 'package:melomix/data/model/artist.dart';

abstract class ArtistState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ArtistInitial extends ArtistState {}

class ArtistLoading extends ArtistState {}

class ArtistSuccess extends ArtistState {
  final List<Artist> artists;

  ArtistSuccess({required this.artists});

  @override
  List<Object?> get props => [artists];
}

class ArtistUpdated extends ArtistState {
  final Artist artist;

  ArtistUpdated({required this.artist});

  @override
  List<Object?> get props => [artist];
}

class ArtistDeleted extends ArtistState {
  final int artistId;

  ArtistDeleted({required this.artistId});

  @override
  List<Object?> get props => [artistId];
}

class ArtistError extends ArtistState {
  final String message;

  ArtistError({required this.message});

  @override
  List<Object?> get props => [message];
}