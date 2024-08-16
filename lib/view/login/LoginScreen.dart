import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:melomix/routes.dart';
import 'package:melomix/services/api_services.dart';
import 'package:melomix/services/storage_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final ApiServices _apiServices = ApiServices(); // Instancia del servicio de API

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50], // Color de fondo suave
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Iniciar Sesión',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese un nombre de usuario';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      prefixIcon: Icon(Icons.lock),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese una contraseña';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 30),
                  // Método para iniciar sesión en LoginScreen
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        String username = _usernameController.text.trim();
                        String password = _passwordController.text.trim();

                        // Intento de inicio de sesión
                        bool loginSuccess = await _apiServices.loginUser(username, password);

                        if (loginSuccess) {
                          final storageService = StorageService();

                          // Almacenar los datos de usuario en SharedPreferences
                          await storageService.saveUserData(
                            'dummy_id_token', // Aquí deberías usar el valor real del id_token
                            'dummy_access_token', // Aquí deberías usar el valor real del access_token
                            'dummy_refresh_token', // Aquí deberías usar el valor real del refresh_token
                            'admin', // Aquí deberías usar el valor real de user_group desde la respuesta
                          );

                          // Recuperar el grupo de usuario para la redirección
                          String? userGroup = storageService.userGroup;

                          // Redirección según el grupo de usuario
                          if (userGroup == 'admin') {
                            print('User Group: $userGroup');
                            Get.offAllNamed(AppRoutes.homeadmin); // Redirige al panel de admin
                          } else if (userGroup == 'usuario') {
                            Get.offAllNamed(AppRoutes.home); // Redirige al home normal
                          } else {
                            Get.offAllNamed(AppRoutes.login); // Redirige al login si el grupo es inválido
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Inicio de sesión fallido, revise sus credenciales')),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey, // Color de fondo del botón
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text(
                      'Iniciar Sesión',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),

                  SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.home);
                    },
                    child: Text('Ir al Home'),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
                    ),
                  ),
                  SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.register); // Navega a la pantalla de registro
                    },
                    child: Text('¿No tienes una cuenta? Regístrate'),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
                    ),
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
