import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Importa GetX para la navegación
import 'package:melomix/routes.dart'; // Importa tus rutas

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Iniciar Sesión'),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Get.back(); // Usa GetX para volver a la pantalla anterior
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
                      return 'Please enter an email';
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
                      return 'Please enter a password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      // Aquí puedes añadir la lógica para iniciar sesión
                      Get.back(); // Vuelve a la pantalla anterior después de iniciar sesión
                    }
                  },
                  child: Text('Iniciar Sesión'),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.main); // Navega a la pantalla principal sin iniciar sesión
                  },
                  child: Text('Ir al Home'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
