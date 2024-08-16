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
        body: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'MelonMix',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 30),
                Card(
                  color: Colors.grey[850],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: 350),
                            child: _buildTextField(
                              controller: _usernameController,
                              labelText: 'Nombre de Usuario',
                              validator: (value) =>
                                  value!.isEmpty ? 'El nombre de usuario es requerido' : null,
                            ),
                          ),
                          SizedBox(height: 15),
                          ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: 350),
                            child: _buildTextField(
                              controller: _emailController,
                              labelText: 'Correo Electrónico',
                              validator: (value) =>
                                  value!.isEmpty ? 'Por favor ingrese un email' : null,
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                          SizedBox(height: 15),
                          ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: 350),
                            child: _buildPasswordField(
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
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Sugerencias: Al menos 8 caracteres, una letra mayúscula y un símbolo',
                            style: TextStyle(color: Colors.grey[400], fontSize: 12),
                          ),
                          SizedBox(height: 15),
                          ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: 350),
                            child: _buildPasswordField(
                              controller: _confirmPasswordController,
                              labelText: 'Confirmar Contraseña',
                              validator: (value) =>
                                  value != _passwordController.text ? 'Las contraseñas no coinciden' : null,
                            ),
                          ),
                          SizedBox(height: 30),
                          ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: 250),
                            child: ElevatedButton(
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
                              child: Text('Registrarse', style: TextStyle(fontSize: 20)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent,
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                _buildAdditionalOptions(),
              ],
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
    return TextFormField(
      controller: controller,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.grey[400]),
        filled: true,
        fillColor: Colors.grey[800],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      validator: validator,
      keyboardType: keyboardType,
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String labelText,
    String? Function(String?)? validator,
  }) {
    bool _obscureText = true;

    return StatefulBuilder(
      builder: (context, setState) {
        return TextFormField(
          controller: controller,
          obscureText: _obscureText,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: TextStyle(color: Colors.grey[400]),
            filled: true,
            fillColor: Colors.grey[800],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
              borderRadius: BorderRadius.circular(8),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            ),
          ),
          validator: validator,
        );
      },
    );
  }

  Widget _buildAdditionalOptions() {
    return Column(
      children: [
        TextButton(
          onPressed: () {
            Get.toNamed(AppRoutes.login);
          },
          child: Text(
            '¿Ya tienes una cuenta? Inicia sesión',
            style: TextStyle(color: Colors.grey[400]),
          ),
        ),
      ],
    );
  }
}
