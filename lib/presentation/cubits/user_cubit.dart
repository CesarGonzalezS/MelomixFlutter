import 'package:bloc/bloc.dart';
import 'package:melomix/data/model/user_model.dart';
import 'package:melomix/services/api_services.dart'; // Asegúrate de que este sea el nombre correcto del archivo
import 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final ApiServices apiServices; // Define apiServices como un campo de la clase

  UserCubit({required this.apiServices}) : super(UserInitial());

  Future<void> createUser(User_model user) async {
    try {
      emit(UserLoading());
      await apiServices.createUser(user);
      emit(UserSuccess(users: [])); // Si necesitas manejar la lista de usuarios
    } catch (e) {
      emit(UserError(message: e.toString()));
    }
  }
}
