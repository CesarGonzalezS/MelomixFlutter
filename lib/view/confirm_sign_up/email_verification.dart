import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:melomix/routes.dart';
import 'package:melomix/services/storage_service.dart';
import 'package:melomix/services/api_services.dart';

class EmailVerificationScreen extends StatefulWidget {
  @override
  _EmailVerificationScreenState createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  String _verificationCode = '';
  bool _isLoading = false;
  String _errorMessage = '';

  void _showAlert(BuildContext context, String title, String message) {
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
                Get.offNamed(AppRoutes.login); // Redirige a la pantalla de inicio de sesión
              },
            ),
          ],
        );
      },
    );
  }

  void _verifyCode(BuildContext context, String usernamed) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _errorMessage = '';
      });

      // Recupera el username de SharedPreferences
      final String username = Get.arguments?['username'] ?? StorageService().username ?? 'Usuario';

      // Imprime el username y el código de verificación
      print('Username: $username');
      print('Verification Code: $_verificationCode');

      // Llama a la API para verificar el código
      final response = await ApiServices().verifyEmail(username!, _verificationCode);

      setState(() {
        _isLoading = false;
      });

      if (response['message'] == 'User confirmed') {
        _showAlert(context, 'Éxito', 'Su usuario ha sido verificado exitosamente.');
      } else {
        setState(() {
          _errorMessage = 'El código de verificación es incorrecto';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Recupera el username pasado como argumento o del Storage
    final String username = Get.arguments?['username'] ?? StorageService().username ?? 'Usuario';

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Verificación de usuario'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Verifique su usuario',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Hemos enviado un código de verificación a $username. Por favor, ingréselo a continuación.',
                style: TextStyle(color: Colors.white, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Container(
                constraints: BoxConstraints(maxWidth: 600, minHeight: 200),
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
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Código de verificación',
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese el código de verificación';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          _verificationCode = value;
                        },
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                          textStyle: TextStyle(fontSize: 18),
                        ),
                        onPressed: () => _verifyCode(context, username),
                        child: _isLoading
                            ? CircularProgressIndicator()
                            : Text('Verificar'),
                      ),
                      SizedBox(height: 10),
                      if (_errorMessage.isNotEmpty)
                        Text(
                          _errorMessage,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          style: TextStyle(color: Colors.red, fontSize: 16),
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
