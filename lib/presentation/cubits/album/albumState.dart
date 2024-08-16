import 'package:equatable/equatable.dart';
import 'package:melomix/data/model/albums.dart';

abstract class AlbumState extends Equatable {
  @override
  List<Object?> get props => [];
}
class AlbumInitial extends AlbumState{}

class AlbumLoading extends AlbumState{}

class AlbumSuccess extends AlbumState{
  final List<Album> albums;
  AlbumSuccess({required this.albums});

  @override
  List<Object?> get props => [albums];
}

class AlbumError extends AlbumState{
  final String message;

  AlbumError({required this.message});

  @override
  List<Object?> get props => [message];
}

