import 'package:flutter/material.dart';

class EmailVerificationScreen extends StatefulWidget {
  final String email;

  EmailVerificationScreen({required this.email});

  @override
  _EmailVerificationScreenState createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  String _verificationCode = '';
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

  void _verifyCode() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _errorMessage = '';
      });

      // Simulación del envío del código de verificación al servidor y espera de la respuesta
      await Future.delayed(Duration(seconds: 2));

      // Aquí iría la lógica para enviar el código de verificación al servidor
      // y manejar la respuesta. Vamos a simular una verificación exitosa.

      // Supongamos que la verificación fue exitosa:
      setState(() {
        _isLoading = false;
      });

      // Mostrar un mensaje de éxito
      _showAlert('Éxito', 'Su correo electrónico ha sido verificado exitosamente.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Verificación de correo'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Texto de bienvenida
              Text(
                'Verifique su correo electrónico',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              // Instrucción para el usuario
              Text(
                'Hemos enviado un código de verificación a ${widget.email}. Por favor, ingréselo a continuación.',
                style: TextStyle(color: Colors.white, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              // Contenedor para el formulario de verificación de código
              Container(
                constraints: BoxConstraints(maxWidth: 600, minHeight: 200), // Controla el ancho máximo del contenedor
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
                      // Campo de texto para el código de verificación
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
                          setState(() {
                            _verificationCode = value;
                          });
                        },
                      ),
                      SizedBox(height: 20),
                      // Botón de verificación
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green, // Color del botón
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                          textStyle: TextStyle(fontSize: 18),
                        ),
                        onPressed: _verifyCode,
                        child: _isLoading
                            ? CircularProgressIndicator() // Mostrar indicador de carga mientras se verifica el código
                            : Text('Verificar'),
                      ),
                      SizedBox(height: 10),
                      // Mensaje de error
                      if (_errorMessage.isNotEmpty)
                        Text(
                          _errorMessage,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true, // Ajustar el texto en caso de que sea demasiado largo para la pantalla
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
