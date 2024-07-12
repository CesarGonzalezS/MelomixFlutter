import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/artists.dart';

abstract class ArtistState extends Equatable {
  @override
  List<Object> get props => [];
}

class ArtistInitial extends ArtistState {}

class ArtistLoading extends ArtistState {}

class ArtistSuccess extends ArtistState {
  final List<Artist> artists;

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

class ArtistCubit extends Cubit<ArtistState> {
  ArtistCubit() : super(ArtistInitial());

  Future<void> loadArtists() async {
    emit(ArtistLoading());

    try {
      // Lógica para obtener los datos de la base de datos o API
      List<Artist> artists = []; // Aquí iría la lógica para obtener los datos

      emit(ArtistSuccess(artists: artists));
    } catch (e) {
      emit(ArtistError(message: 'Failed to load artists: $e'));
    }
  }
}
