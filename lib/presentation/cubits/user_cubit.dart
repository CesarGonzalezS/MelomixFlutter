import 'package:bloc/bloc.dart';
import 'package:get/get.dart';
import 'package:melomix/data/model/user_model.dart';
import 'package:melomix/services/api_services.dart';
import 'package:melomix/presentation/cubits/user_state.dart';
import 'package:melomix/routes.dart'; // Asegúrate de importar tus rutas

class UserCubit extends Cubit<UserState> {
  final ApiServices apiServices;

  UserCubit({required this.apiServices}) : super(UserInitial());

  Future<void> createUser(User_model user) async {
    print('createUser method called'); // Log para verificar que el método se llama
    try {
      emit(UserLoading());
      await apiServices.createUser(user);
      emit(UserSuccess(users: [])); // Emitir éxito en caso de registro exitoso
      print('User successfully created and UserSuccess emitted');

      // Redireccionar después de crear el usuario
      Get.offNamed(AppRoutes.emailVerification, arguments: {'username': user.username});
    } catch (e) {
      print('Error in createUser: $e'); // Log de error
      emit(UserError(message: e.toString()));
    }
  }
}
