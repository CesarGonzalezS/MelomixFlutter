import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melomix/presentation/cubits/user_cubit.dart';
import 'package:melomix/presentation/cubits/user_state.dart';
import 'package:melomix/services/api_services.dart';
import 'package:melomix/data/model/user_model.dart';
import 'package:get/get.dart';
import 'package:melomix/routes.dart';

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
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Center(child: Text('Registro', style: TextStyle(color: Colors.white))),
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: BlocListener<UserCubit, UserState>(
          listener: (context, state) {
            if (state is UserLoading) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (state is UserSuccess) {
              Navigator.pop(context); // Cierra el diálogo de carga
              Get.snackbar(
                'Éxito',
                'Registro exitoso',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.green,
                colorText: Colors.white,
              );

              // Navegar directamente a la pantalla de verificación de correo electrónico
              Get.toNamed(AppRoutes.emailVerification, arguments: {'username': _usernameController.text});
            } else if (state is UserError) {
              Navigator.pop(context); // Cierra el diálogo de carga
              Get.snackbar(
                'Error',
                state.message,
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.red,
                colorText: Colors.white,
              );
            }
          },
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Crea una nueva cuenta',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 20),
                      _buildTextField(
                        controller: _usernameController,
                        labelText: 'Nombre de Usuario',
                        validator: (value) =>
                            value!.isEmpty ? 'El nombre de usuario es requerido' : null,
                      ),
                      SizedBox(height: 15),
                      _buildTextField(
                        controller: _emailController,
                        labelText: 'Correo Electrónico',
                        validator: (value) =>
                            value!.isEmpty ? 'Por favor ingrese un email' : null,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 15),
                      _buildPasswordField(
                        controller: _passwordController,
                        labelText: 'Contraseña',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Por favor ingrese una contraseña';
                          }
                          if (!RegExp(r'(?=.*[A-Z])(?=.*[!@#$%^&*(),.?":{}|<>])')
                              .hasMatch(value)) {
                            return 'La contraseña debe contener al menos una letra mayúscula y un símbolo';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Sugerencias: Al menos 8 caracteres, una letra mayúscula y un símbolo',
                        style: TextStyle(color: Colors.grey[700], fontSize: 12),
                      ),
                      SizedBox(height: 15),
                      _buildPasswordField(
                        controller: _confirmPasswordController,
                        labelText: 'Confirmar Contraseña',
                        validator: (value) => value != _passwordController.text
                            ? 'Las contraseñas no coinciden'
                            : null,
                      ),
                      SizedBox(height: 30),
                      SizedBox(
                        width: 250, // Reduce el ancho del botón
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              final user = User_model(
                                username: _usernameController.text,
                                email: _emailController.text,
                                password: _passwordController.text,
                                dateJoined: DateTime.now().toIso8601String(),
                              );
                              print('Attempting to create user');
                              context.read<UserCubit>().createUser(user);
                            }
                          },
                          child: Text('Registrarse', style: TextStyle(fontSize: 18)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return SizedBox(
      width: 300, // Reduce el ancho del campo de texto
      child: TextFormField(
        controller: controller,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.grey[700]),
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        validator: validator,
        keyboardType: keyboardType,
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String labelText,
    String? Function(String?)? validator,
  }) {
    return SizedBox(
      width: 300, // Reduce el ancho del campo de contraseña
      child: StatefulBuilder(
        builder: (context, setState) {
          bool obscureText = true;
          return TextFormField(
            controller: controller,
            obscureText: obscureText,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              labelText: labelText,
              labelStyle: TextStyle(color: Colors.grey[700]),
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
                borderRadius: BorderRadius.circular(10),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
              ),
            ),
            validator: validator,
          );
        },
      ),
    );
  }
}