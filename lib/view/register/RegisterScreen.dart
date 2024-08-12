// register_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melomix/presentation/cubits/user_cubit.dart';
import 'package:melomix/services/api_services.dart';
import 'package:melomix/data/model/user_model.dart';
import 'package:melomix/routes.dart';
import 'package:melomix/presentation/cubits/user_state.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Lista local para simular el almacenamiento de usuarios
  final List<User_model> _localUsers = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit(apiServices: ApiServices()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Registro'),
          backgroundColor: Colors.blueAccent,
        ),
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
              // Agrega el usuario a la lista local
              _localUsers.add(User_model(
                username: _usernameController.text,
                email: _emailController.text,
                password: _passwordController.text,
                dateJoined: DateTime.now().toIso8601String(),
              ));
              // Navega a la pantalla de verificación de correo
              Get.toNamed(AppRoutes.emailVerification, arguments: {'email': _emailController.text});
            } else if (state is UserError) {
              // Muestra el mensaje de error
              Navigator.pop(context); // Cerrar el diálogo de carga
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) => value!.isEmpty ? 'Required' : null,
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) => value!.isEmpty ? 'Please enter email' : null,
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      obscureText: true,
                      validator: (value) => value!.isEmpty ? 'Please enter password' : null,
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _confirmPasswordController,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
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
                          // Simula la creación de usuario
                          context.read<UserCubit>().createUser(user);
                        }
                      },
                      child: Text('Register'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent, // En lugar de 'primary'
                        foregroundColor: Colors.white, // En lugar de 'onPrimary'
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
