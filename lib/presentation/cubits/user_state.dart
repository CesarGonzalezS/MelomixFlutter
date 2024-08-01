import 'package:equatable/equatable.dart';
import '../../data/model/user_model.dart';

abstract class UserState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserSuccess extends UserState {
  final List<User_model> users;

  UserSuccess({required this.users});

  @override
  List<Object?> get props => [users];
}

class UserError extends UserState {
  final String message;

  UserError({required this.message});

  @override
  List<Object?> get props => [message];
}
