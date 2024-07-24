// side_bar.dart
import 'package:flutter/material.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xff10121D),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 240,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xff1F1F1F),
              ),
              child: Column(
                children: [
                  Image.asset(
                    "assets/img/app_logo.png",
                    width: MediaQuery.of(context).size.width * 0.17,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: const [
                          Text(
                            "328\nSongs",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xffC1C0C0), fontSize: 12),
                          )
                        ],
                      ),
                      Column(
                        children: const [
                          Text(
                            "52\nAlbums",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xffC1C0C0), fontSize: 12),
                          )
                        ],
                      ),
                      Column(
                        children: const [
                          Text(
                            "87\nArtists",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xffC1C0C0), fontSize: 12),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person_add, color: Colors.white),
            title: Text(
              'Register',
              style: TextStyle(
                color: Colors.white,
                backgroundColor: Colors.black.withOpacity(0.3),
              ),// Fondo difuminado
            ),
            onTap: () {
              // Aquí puedes abrir el modal de registro
              Navigator.pop(context); // Cierra el sidebar
              showRegisterModal(context);
            },
          ),
          // Otros elementos del sidebar aquí
          // ...
        ],
      ),
    );
  }

  void showRegisterModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Register',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              // Agrega aquí el formulario de registro
              // ...
            ],
          ),
        );
      },
    );
  }
}
