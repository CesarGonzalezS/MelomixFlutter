import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:melomix/common/color_extension.dart';
import 'package:melomix/common_widget/icon_text_row.dart';
import 'package:melomix/common_widget/mini_player_view.dart';
import 'package:melomix/view/home/home_view.dart';

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
            SizedBox(
              height: 240,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: TColor.primaryText.withOpacity(0.03),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/img/app_logo.png",
                      width: media.width * 0.17,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
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
                    )
                  ],
                ),
              ),
            ),
            IconTextRow(
              title: "Themes",
              icon: "assets/img/m_theme.png",
              onTap: () {},
            ),
            IconTextRow(
              title: "Ringtone Cutter",
              icon: "assets/img/m_ring_cut.png",
              onTap: () {},
            ),
            IconTextRow(
              title: "Sleep Timer",
              icon: "assets/img/m_sleep_timer.png",
              onTap: () {},
            ),
            IconTextRow(
              title: "Equalizer",
              icon: "assets/img/m_eq.png",
              onTap: () {},
            ),
            IconTextRow(
              title: "Driver Mode",
              icon: "assets/img/img3.jpg",
              onTap: () {},
            ),
            IconTextRow(
              title: "Hidden Folders",
              icon: "assets/img/img2.jpg",
              onTap: () {},
            ),
            IconTextRow(
              title: "Scan Media",
              icon: "assets/img/img1.jpg",
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.login),
              title: Text('Register'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Register'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'Username',
                            ),
                          ),
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'Email',
                            ),
                          ),
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'Password',
                            ),
                            obscureText: true,
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            // Register action
                          },
                          child: Text('Register'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
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
                    _scaffoldKey.currentState?.openDrawer();
                  },
                ),
                title: Text('App Name'),
              ),
              Expanded(
                child: TabBarView(
                  controller: controller,
                  children: [
                    HomeView(),
                    Container(), // Placeholder for Search view
                    Container(), // Placeholder for Library view
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
            selectTab = index;
            controller?.animateTo(index);
          });
        },
      ),
    );
  }
}
