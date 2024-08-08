// register_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:melomix/services/user/api_service_create_user.dart';
import 'package:melomix/data/model/user_model.dart';
import 'package:melomix/common_widget/animated_logo.dart';
import 'package:melomix/routes.dart';
import 'package:intl/intl.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';
  String _dateOfBirth = '';
  bool _isLoading = false;
  String _errorMessage = '';
  TextEditingController _dateController = TextEditingController();

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

  void _register() async {
    if (_formKey.currentState!.validate()) {
      if (_password != _confirmPassword) {
        _showAlert('Error', 'Las contraseñas no coinciden.');
        return;
      }

      setState(() {
        _isLoading = true;
        _errorMessage = '';
      });

      final user = User_model(
        userId: '',
        username: _username,
        email: _email,
        password: _password,
        dateJoined: _dateOfBirth,
      );

      try {
        await ApiServices().createUser(user);
        setState(() {
          _isLoading = false;
        });
        Get.toNamed(AppRoutes.emailVerification, arguments: {'email': _email});
      } catch (e) {
        setState(() {
          _isLoading = false;
          _errorMessage = e.toString();
        });
        _showAlert('Error', 'Hubo un problema al registrar el usuario.');
      }
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
              AnimatedLogo(),
              SizedBox(height: 10),
              Text(
                'Registro de Usuario',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
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
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Nombre de usuario',
                          labelStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),
                        ),
                        style: TextStyle(color: Colors.white),
                        onChanged: (value) {
                          setState(() {
                            _username = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa tu nombre de usuario';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Correo electrónico',
                          labelStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),
                        ),
                        style: TextStyle(color: Colors.white),
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          setState(() {
                            _email = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty || !RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                            return 'Por favor ingresa un correo electrónico válido';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Contraseña',
                          labelStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),
                        ),
                        style: TextStyle(color: Colors.white),
                        obscureText: true,
                        onChanged: (value) {
                          setState(() {
                            _password = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa tu contraseña';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Confirmar contraseña',
                          labelStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),
                        ),
                        style: TextStyle(color: Colors.white),
                        obscureText: true,
                        onChanged: (value) {
                          setState(() {
                            _confirmPassword = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor confirma tu contraseña';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _dateController,
                        decoration: InputDecoration(
                          labelText: 'Fecha de nacimiento',
                          labelStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),
                        ),
                        style: TextStyle(color: Colors.white),
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );

                          if (pickedDate != null) {
                            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                            setState(() {
                              _dateOfBirth = formattedDate;
                              _dateController.text = formattedDate;
                            });
                          }
                        },
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                          textStyle: TextStyle(fontSize: 18),
                        ),
                        onPressed: _register,
                        child: _isLoading
                            ? CircularProgressIndicator()
                            : Text('Registrarse'),
                      ),
                      SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          Get.toNamed(AppRoutes.passwordRecovery);
                        },
                        child: Text(
                          '¿Olvidaste tu contraseña?',
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          Get.offNamed(AppRoutes.splash);
                        },
                        child: Text(
                          '¿Ya tienes una cuenta? Iniciar sesión',
                          style: TextStyle(color: Colors.green),
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
