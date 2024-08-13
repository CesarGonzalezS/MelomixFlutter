// splash_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:melomix/routes.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    // Simular carga y luego navegar al login
    Future.delayed(Duration(seconds: 2), () {
      Get.offNamed(AppRoutes.login); // Navegar al login
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/img/logomelomix.jpg",
          width: 200, // Ajusta el tamaño como necesites
        ),
      ),
    );
  }
}
