import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/users.dart';

abstract class UserState extends Equatable {
  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserSuccess extends UserState {
  final List<User> users;

  UserSuccess({required this.users});

  @override
  List<Object> get props => [users];
}

class UserError extends UserState {
  final String message;

  UserError({required this.message});

  @override
  List<Object> get props => [message];
}

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  // Método para cargar los datos de users
  Future<void> loadUsers() async {
    emit(UserLoading());

    try {
      // Lógica para obtener los datos de la base de datos o API
      List<User> users = []; // Aquí iría la lógica para obtener los datos

      emit(UserSuccess(users: users));
    } catch (e) {
      emit(UserError(message: 'Failed to load users: $e'));
    }
  }
}
