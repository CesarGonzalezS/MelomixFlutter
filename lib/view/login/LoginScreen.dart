// login_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:melomix/routes.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Lista de usuarios administradores locales
  final List<Map<String, String>> _localAdminUsers = [
    {'email': 'admin', 'password': 'admin'},
    {'email': 'admin456', 'password': 'admin'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Iniciar Sesión'),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese un email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese una contraseña';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      String enteredEmail = _emailController.text.trim().toLowerCase();
                      String enteredPassword = _passwordController.text.trim();

                      print('Credenciales ingresadas: email=$enteredEmail, password=$enteredPassword');

                      // Verificar si es un usuario administrador local
                      bool isLocalAdmin = _localAdminUsers.any((admin) =>
                      admin['email']!.toLowerCase() == enteredEmail && admin['password'] == enteredPassword
                      );

                      if (isLocalAdmin) {
                        print('Usuario administrador local autenticado');
                        Get.toNamed(AppRoutes.admin); // Navega a la pantalla de administrador
                      } else {
                        print('Credenciales incorrectas');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Inicio de sesión fallido, revise sus credenciales')),
                        );
                      }
                    }
                  },
                  child: Text('Iniciar Sesión'),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.main);
                  },
                  child: Text('Ir al Home'),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.register); // Navega a la pantalla de registro
                  },
                  child: Text('¿No tienes una cuenta? Regístrate'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
