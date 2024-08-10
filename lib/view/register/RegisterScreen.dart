import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melomix/presentation/cubits/user_cubit.dart';
import 'package:melomix/services/api_services.dart';
import 'package:melomix/data/model/user_model.dart';
import 'package:melomix/routes.dart';
import 'package:melomix/presentation/cubits/user_state.dart';
import 'package:get/get.dart'; // Importa GetX para la navegación

class RegisterScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit(apiServices: ApiServices()),
      child: Scaffold(
        appBar: AppBar(title: Text('Registro')),
        body: BlocListener<UserCubit, UserState>(
          listener: (context, state) {
            if (state is UserLoading) {
              // Muestra un indicador de carga
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              );
            } else if (state is UserSuccess) {
              // Cerrar el diálogo de carga
              Navigator.pop(context);
              // Mostrar mensaje de éxito
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Registro exitoso')),
              );
              // Navega a la siguiente pantalla
              Get.toNamed(AppRoutes.emailVerification, arguments: {'email': _emailController.text});
            } else if (state is UserError) {
              // Muestra el mensaje de error
              Navigator.pop(context); // Cerrar el diálogo de carga
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(labelText: 'Username'),
                    validator: (value) => value!.isEmpty ? 'Required' : null,
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                    validator: (value) => value!.isEmpty ? 'Please enter email' : null,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    validator: (value) => value!.isEmpty ? 'Please enter password' : null,
                  ),
                  TextFormField(
                    controller: _confirmPasswordController,
                    decoration: InputDecoration(labelText: 'Confirm Password'),
                    obscureText: true,
                    validator: (value) => value != _passwordController.text ? 'Passwords do not match' : null,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final user = User_model(
                          username: _usernameController.text,
                          email: _emailController.text,
                          password: _passwordController.text,
                          dateJoined: DateTime.now().toIso8601String(),
                        );
                        context.read<UserCubit>().createUser(user);
                      }
                    },
                    child: Text('Register'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
