// password_recovery_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Importa GetX para la navegación
import 'package:melomix/routes.dart'; // Importa tus rutas
import 'package:melomix/common_widget/animated_logo.dart'; // Ruta al widget del logo animado

class PasswordRecoveryScreen extends StatefulWidget {
  @override
  _PasswordRecoveryScreenState createState() => _PasswordRecoveryScreenState();
}

class _PasswordRecoveryScreenState extends State<PasswordRecoveryScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  bool _isLoading = false;
  String _errorMessage = '';

  // Método para mostrar un diálogo de alerta
  void _showAlert(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _recoverPassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _errorMessage = '';
      });

      // Aquí iría la lógica para enviar el correo al servidor para recuperar la contraseña
      await Future.delayed(Duration(seconds: 2));

      // Supongamos que la solicitud fue exitosa:
      setState(() {
        _isLoading = false;
      });

      // Mostrar un diálogo de éxito
      _showAlert('Éxito', 'Se ha enviado un correo electrónico para recuperar su contraseña.');

      // Regresar a la pantalla de inicio de sesión
      Get.offNamed(AppRoutes.login); // Navega a la pantalla de login usando GetX
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Logo de bienvenida con animación
              AnimatedLogo(),
              SizedBox(height: 10),
              // Texto de bienvenida
              Text(
                'Recuperar Contraseña',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              // Contenedor para el formulario de recuperación de contraseña
              Container(
                constraints: BoxConstraints(maxWidth: 600, minHeight: 300),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 15,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Campo de texto para el email
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Correo electrónico',
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese su correo electrónico';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            _email = value;
                          });
                        },
                      ),
                      SizedBox(height: 20),
                      // Botón de recuperación de contraseña
                      ElevatedButton(
                        onPressed: _isLoading ? null : _recoverPassword,
                        child: _isLoading
                            ? CircularProgressIndicator()
                            : Text('Recuperar Contraseña'),
                      ),
                      SizedBox(height: 10),
                      // Mensaje de error
                      if (_errorMessage.isNotEmpty)
                        Text(
                          _errorMessage,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          style: TextStyle(color: Colors.red, fontSize: 16),
                        ),
                      SizedBox(height: 10),
                      // Texto y botón para ir a la pantalla de inicio de sesión
                      Text(
                        '¿Ya tienes una cuenta?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.offNamed(AppRoutes.login); // Navega a la pantalla de login
                        },
                        child: Text(
                          'Iniciar sesión',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 18,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
