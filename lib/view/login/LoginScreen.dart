import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:melomix/routes.dart';
import 'package:melomix/services/api_services.dart';
import 'package:melomix/services/storage_service.dart'; // Importa StorageService

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
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        String username = _usernameController.text.trim();
                        String password = _passwordController.text.trim();

                        bool loginSuccess = await _apiServices.loginUser(username, password);

                        if (loginSuccess) {
                          final storageService = StorageService();

                          // Aquí puedes simular el almacenamiento de los datos
                          await storageService.saveUserData(
                            'dummy_id_token',
                            'dummy_access_token',
                            'dummy_refresh_token',
                            'usuario',
                          );

                          // Imprime los datos almacenados
                          print('ID Token: ${storageService.idToken}');
                          print('Access Token: ${storageService.accessToken}');
                          print('Refresh Token: ${storageService.refreshToken}');
                          print('User Group: ${storageService.userGroup}');

                          String? userGroup = storageService.userGroup;

                          if (userGroup == 'admin') {
                            Get.offAllNamed(AppRoutes.homeadmin);
                            print('Redirigiendo a HomeAdmin');
                          } else if (userGroup == 'usuario') {
                            Get.offAllNamed(AppRoutes.home);
                          } else {
                            Get.offAllNamed(AppRoutes.home);
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
