import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:melomix/common/color_extension.dart';
import 'package:melomix/common_widget/icon_text_row.dart';
import 'package:melomix/common_widget/mini_player_view.dart';
import 'package:melomix/view/home/home_view.dart';  // Asegúrate de que este archivo contiene HomeView
import 'package:melomix/view_model/splash_view_model.dart';  // Asegúrate de que la ruta es correcta

// Importa SplashViewModel si es el tipo correcto
import 'package:melomix/view_model/splash_view_model.dart';

class MainTabView extends StatefulWidget {
  const MainTabView({super.key});

  @override
  State<MainTabView> createState() => _MainTabViewState();
}

class _MainTabViewState extends State<MainTabView>
    with SingleTickerProviderStateMixin {
  TabController? controller;
  int selectTab = 0;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);

    controller?.addListener(() {
      selectTab = controller?.index ?? 0;
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);

    // Asegúrate de que SplashViewModel está correctamente definido
    //var splashVM = Get.find<SplashViewModel>();

    return Scaffold(
      //key: splashVM.scaffoldKey,
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
                        "assets/img/logomelomix.jpg",
                        width: media.width * 0.17,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text(
                                "328\nSongs",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color(0xffC1C0C0), fontSize: 12),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "52\nAlbums",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color(0xffC1C0C0), fontSize: 12),
                              )
                            ],
                          ),
                          Column(
                            children: [
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
                icon: "assets/img/album.png",
                onTap: () {},
              ),
              IconTextRow(
                title: "Ringtone Cutter",
                icon: "",
                onTap: () {},
              ),
              IconTextRow(
                title: "Sleep Timer",
                icon: "",
                onTap: () {},
              ),
              IconTextRow(
                title: "Equalizer",
                icon: "",
                onTap: () {},
              ),
              IconTextRow(
                title: "Driver Mode",
                icon: "",
                onTap: () {},
              ),
              IconTextRow(
                title: "Hidden Folders",
                icon: "",
                onTap: () {},
              ),
              IconTextRow(
                title: "Scan Media",
                icon: "",
                onTap: () {},
              ),
            ],
          )),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          TabBarView(
            controller: controller,
            children: [
              //HomeView(),
              // Puedes descomentar estas líneas si también las vistas están definidas
              // SongsView(),
              // SettingsView(),
            ],
          ),
          MiniPlayerView(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: TColor.bg, boxShadow: const [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 5,
            offset: Offset(0, -3),
          )
        ]),
        child: BottomAppBar(
            color: Colors.transparent,
            elevation: 0,
            child: TabBar(
              controller: controller,
              indicatorColor: Colors.transparent,
              indicatorWeight: 1,
              labelColor: TColor.primary,
              labelStyle: const TextStyle(fontSize: 10),
              unselectedLabelColor: TColor.primaryText28,
              unselectedLabelStyle: const TextStyle(fontSize: 10),
              tabs: [
                Tab(
                  text: "Home",
                  icon: Image.asset(
                    selectTab == 0
                        ? "assets/img/homa.png"
                        : "assets/img/homa.png",
                    width: 20,
                    height: 20,
                  ),
                ),
                // Puedes eliminar el tab correspondiente si también se elimina la vista
                // Tab(
                //   text: "Songs",
                //   icon: Image.asset(
                //     selectTab == 1
                //         ? "assets/img/songs_tab.png"
                //         : "assets/img/songs_tab_un.png",
                //     width: 20,
                //     height: 20,
                //   ),
                // ),
                // Tab(
                //   text: "Settings",
                //   icon: Image.asset(
                //     selectTab == 2
                //         ? "assets/img/songs_tab.png"
                //         : "assets/img/setting_tab_un.png",
                //     width: 20,
                //     height: 20,
                //   ),
                // )
              ],
            )),
      ),
    );
  }
}
