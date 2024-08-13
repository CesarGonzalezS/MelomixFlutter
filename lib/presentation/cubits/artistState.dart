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

class ArtistError extends ArtistState {
  final String message;

  ArtistError({required this.message});

  @override
  List<Object?> get props => [message];
}