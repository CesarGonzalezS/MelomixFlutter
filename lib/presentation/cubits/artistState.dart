import 'package:equatable/equatable.dart';
import 'package:melomix/data/model/artist.dart'; // Importa el modelo de artista

abstract class ArtistState extends Equatable {
  @override
  List<Object> get props => [];
}

class ArtistInitial extends ArtistState {}

class ArtistLoading extends ArtistState {}

class ArtistSuccess extends ArtistState {
  final List<Artist> artists; // Lista de artistas para el estado de éxito

  ArtistSuccess({required this.artists});

  @override
  List<Object> get props => [artists];
}

class ArtistError extends ArtistState {
  final String message;

  ArtistError({required this.message});

  @override
  List<Object> get props => [message];
}