import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:melomix/routes.dart';
import 'package:melomix/services/api_services.dart';

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
                  controller: _usernameController,
                  decoration: InputDecoration(labelText: 'Username'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese un nombre de usuario';
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
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      String username = _usernameController.text.trim();
                      String password = _passwordController.text.trim();

                      print('Credenciales ingresadas: username=$username, password=$password');

                      bool loginSuccess = await _apiServices.loginUser(username, password);

                      if (loginSuccess) {
                        print('Inicio de sesión exitoso');

                        // Verifica el grupo de usuario y redirige a la ruta correspondiente
                        final prefs = await SharedPreferences.getInstance();
                        String? userGroup = prefs.getString('user_group');

                        if (userGroup == 'admin') {
                          Get.toNamed(AppRoutes.admin);
                        } else {
                          Get.toNamed(AppRoutes.home);
                        }
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
                    Get.toNamed(AppRoutes.home);
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
