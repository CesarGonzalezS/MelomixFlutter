import 'package:equatable/equatable.dart';
import '../../data/model/songs_model.dart'; 

abstract class SongState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SongInitial extends SongState {}

class SongLoading extends SongState {}

class SongSuccess extends SongState {
  final List<Song> songs;

  SongSuccess({required this.songs});

  @override
  List<Object?> get props => [songs];
}

class SongError extends SongState {
  final String message;

  SongError({required this.message});

  @override
  List<Object?> get props => [message];
}
