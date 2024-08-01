import 'package:bloc/bloc.dart';
import 'package:melomix/data/model/user_model.dart';
import 'package:melomix/services/user/api_service_create_user.dart'; // Importa ApiServices
import 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final ApiServices apiServices;

  UserCubit({required this.apiServices}) : super(UserInitial());

  Future<void> createUser(User_model user) async {
    try {
      emit(UserLoading());
      await apiServices.createUser(user);
      final users = await apiServices.getAllUsers(); // Usa ApiServices
      emit(UserSuccess(users: users));
    } catch (e) {
      emit(UserError(message: e.toString()));
    }
  }


}
