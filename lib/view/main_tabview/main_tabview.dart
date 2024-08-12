import 'package:flutter/material.dart';
import 'package:melomix/view/splash_login.dart';
import 'package:get/get.dart'; // Asegúrate de importar GetX
import 'package:melomix/common/color_extension.dart';
import 'package:melomix/common_widget/icon_text_row.dart';
import 'package:melomix/common_widget/mini_player_view.dart';
import 'package:melomix/view/home/home_view.dart';
import 'package:melomix/routes.dart'; // Importa tu archivo de rutas

class MainTabView extends StatefulWidget {
  const MainTabView({super.key});

  @override
  State<MainTabView> createState() => _MainTabViewState();
}

class _MainTabViewState extends State<MainTabView> with SingleTickerProviderStateMixin {
  bool _isMenuExpanded = false; // Controla si el menú está expandido
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

  void _onPlayPause() {
    // Implementa la lógica de play/pause
  }

  void _onSkipBack() {
    // Implementa la lógica de skip back
  }

  void _onSkipForward() {
    // Implementa la lógica de skip forward
  }

  void _onShuffle() {
    // Implementa la lógica de shuffle
  }

  void _onRepeat() {
    // Implementa la lógica de repeat
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: _isMenuExpanded ? 250.0 : 70.0, // Ancho del menú
                color: const Color(0xff10121D), // Color de fondo del menú
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
                          ? Text('Register', style: TextStyle(color: Colors.white))
                          : null,
                      onTap: () {
                        Get.toNamed(AppRoutes.register); // Navega a la pantalla de registro
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.person_add, color: Colors.white),
                      title: _isMenuExpanded
                          ? Text('Register', style: TextStyle(color: Colors.white))
                          : null,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SplashView()), // Navega a SplashView
                        );
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Scaffold(
                  body: TabBarView(
                    controller: controller,
                    children: [
                      HomeView(),
                      Container(), // Placeholder for Search view
                      Container(), // Placeholder for Library view
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: PlayerControls(
              onPlayPause: _onPlayPause,
              onSkipBack: _onSkipBack,
              onSkipForward: _onSkipForward,
              onShuffle: _onShuffle,
              onRepeat: _onRepeat,
              currentPosition: Duration(seconds: 120), // Ejemplo de duración actual
              totalDuration: Duration(minutes: 3), // Ejemplo de duración total
              onSeek: (value) {
                // Implementa la lógica para avanzar en la canción
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PlayerControls extends StatelessWidget {
  final Function() onPlayPause;
  final Function() onSkipBack;
  final Function() onSkipForward;
  final Function() onShuffle;
  final Function() onRepeat;
  final Duration currentPosition;
  final Duration totalDuration;
  final ValueChanged<double> onSeek;

  PlayerControls({
    required this.onPlayPause,
    required this.onSkipBack,
    required this.onSkipForward,
    required this.onShuffle,
    required this.onRepeat,
    required this.currentPosition,
    required this.totalDuration,
    required this.onSeek,
  });

  @override
  Widget build(BuildContext context) {
    final double progress = currentPosition.inSeconds.toDouble() / totalDuration.inSeconds.toDouble();

    return Container(
      color: Color.fromARGB(255, 15, 15, 15),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 1),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.shuffle, size: 16, color: Colors.white),
                onPressed: onShuffle,
              ),
              IconButton(
                icon: Icon(Icons.skip_previous, size: 16, color: Colors.white),
                onPressed: onSkipBack,
              ),
              IconButton(
                icon: Icon(Icons.play_arrow, size: 20, color: Colors.white), // Cambia a play/pause según el estado
                onPressed: onPlayPause,
              ),
              IconButton(
                icon: Icon(Icons.skip_next, size: 16, color: Colors.white),
                onPressed: onSkipForward,
              ),
              IconButton(
                icon: Icon(Icons.repeat, size: 16, color: Colors.white),
                onPressed: onRepeat,
              ),
            ],
          ),
          SizedBox(height: 3), // Espacio entre los botones y el Slider
          Center(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _formatDuration(currentPosition),
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    SizedBox(
                      width: 450, // Ajusta el ancho del Slider
                      child: Container(
                        height: 1, // Ajusta la altura del Slider
                        child: Slider(
                          value: progress,
                          onChanged: onSeek,
                          activeColor: Colors.white,
                          inactiveColor: Colors.grey,
                          min: 0,
                          max: 1,
                        ),
                      ),
                    ),
                    Text(
                      _formatDuration(totalDuration),
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '${minutes}:${seconds.toString().padLeft(2, '0')}';
  }
}

class IconTextRow extends StatelessWidget {
  final String title;
  final String icon;
  final bool isExpanded;
  final VoidCallback onTap;

  const IconTextRow({
    required this.title,
    required this.icon,
    required this.onTap,
    this.isExpanded = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(icon, width: 20, color: Colors.white),
      title: isExpanded ? Text(title, style: TextStyle(color: Colors.white)) : null,
      onTap: onTap,
    );
  }
}