import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:melomix/common/color_extension.dart';
import 'package:melomix/common_widget/icon_text_row.dart';
import 'package:melomix/common_widget/mini_player_view.dart';
import 'package:melomix/view/home/home_view.dart';
import 'package:melomix/view/admin/song_crud_screen.dart';

class MainTabView extends StatefulWidget {
  const MainTabView({super.key});

  @override
  State<MainTabView> createState() => _MainTabViewState();
}

class _MainTabViewState extends State<MainTabView>
    with SingleTickerProviderStateMixin {
  TabController? controller;
  int selectTab = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this); // Adjust length to the number of tabs

    controller?.addListener(() {
      setState(() {
        selectTab = controller?.index ?? 0;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
Widget build(BuildContext context) {
  var media = MediaQuery.sizeOf(context);

  return Scaffold(
    key: _scaffoldKey,
    drawer: Drawer(
      backgroundColor: const Color(0xff10121D),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // (Tu código para el drawer aquí...)
        ],
      ),
    ),
    body: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Column(
          children: [
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  Navigator.pushNamed(context, '/search'); // Navega a la pantalla de búsqueda
                },
              ),
              title: Text('App Name'),
              actions: [
                IconButton(
                  icon: Icon(Icons.admin_panel_settings),
                  onPressed: () {
                    Navigator.pushNamed(context, '/songCrud');
                  },
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: controller,
                children: [
                  HomeView(),
                  Container(), // Placeholder para SearchScreen (no necesario si usas Navigator)
                  Container(), // Placeholder para Library view
                ],
              ),
            ),
          ],
        ),
        MiniPlayerView(),
      ],
    ),
    bottomNavigationBar: BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.library_music),
          label: 'Library',
        ),
      ],
      currentIndex: selectTab,
      selectedItemColor: Color.fromARGB(255, 160, 5, 5),
      unselectedItemColor: Colors.white,
      backgroundColor: Color.fromARGB(255, 15, 15, 15),
      onTap: (index) {
        setState(() {
          if (index == 1) {
            Navigator.pushNamed(context, '/search'); // Navega a la pantalla de búsqueda
          } else {
            selectTab = index;
            controller?.animateTo(index);
          }
        });
      },
    ),
  );
}
    }