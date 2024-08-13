import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:melomix/common_widget/icon_text_row.dart';
import 'package:melomix/view/home/home_view.dart';
import 'package:melomix/routes.dart';

class MainTabView extends StatefulWidget {
  const MainTabView({super.key});

  @override
  State<MainTabView> createState() => _MainTabViewState();
}

class _MainTabViewState extends State<MainTabView> with SingleTickerProviderStateMixin {
  bool _isMenuExpanded = false;
  TabController? controller;
  int selectTab = 0;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);

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
    return Scaffold(
      body: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: _isMenuExpanded ? 250.0 : 70.0,
            color: const Color(0xff10121D),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(
                    _isMenuExpanded ? Icons.arrow_back : Icons.menu,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      _isMenuExpanded = !_isMenuExpanded;
                    });
                  },
                ),
                IconTextRow(
                  title: "Driver Mode",
                  icon: "assets/img/img3.jpg",
                  onTap: () {},
                  isExpanded: _isMenuExpanded,
                ),
                IconTextRow(
                  title: "Hidden Folders",
                  icon: "assets/img/img2.jpg",
                  onTap: () {},
                  isExpanded: _isMenuExpanded,
                ),
                IconTextRow(
                  title: "Scan Media",
                  icon: "assets/img/img1.jpg",
                  onTap: () {},
                  isExpanded: _isMenuExpanded,
                ),
                ListTile(
                  leading: Icon(Icons.login, color: Colors.white),
                  title: _isMenuExpanded
                      ? Text('Login', style: TextStyle(color: Colors.white))
                      : null,
                  onTap: () {
                    Get.toNamed(AppRoutes.login);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.person_add, color: Colors.white),
                  title: _isMenuExpanded
                      ? Text('Register', style: TextStyle(color: Colors.white))
                      : null,
                  onTap: () {
                    Get.toNamed(AppRoutes.register);
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Scaffold(
              body: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: TabBarView(
                          controller: controller,
                          children: [
                            HomeView(),
                            Container(), // Vista de búsqueda
                            Container(), // Vista de biblioteca
                          ],
                        ),
                      ),
                    ],
                  ),
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
                    selectTab = index;
                    controller?.animateTo(index);
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
