// home_admin.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:melomix/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeAdmin extends StatefulWidget {
  @override
  _HomeAdminState createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) async {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Get.toNamed(AppRoutes.albums);
        break;
      case 1:
        Get.toNamed(AppRoutes.artists);
        break;
      case 2:
        Get.toNamed(AppRoutes.songs);
        break;
      case 3:
        final prefs = await SharedPreferences.getInstance();
        await prefs.clear();
        //navigate to home and remove all previos routes on Navigator
        Get.offAllNamed(AppRoutes.home);   
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Panel de Administración'),
      ),
      body: Center(
        child: Text(
          'Bienvenido al Panel de Administración',
          style: TextStyle(fontSize: 24),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.album),
            label: 'Albums',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Artists',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.music_note),
            label: 'Songs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Salir',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.black,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed, // Asegura que todos los ítems tengan nombre
      ),
    );
  }
}
