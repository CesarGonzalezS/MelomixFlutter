import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:melomix/routes.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),  // Asumiendo que tienes una HomePage
    SearchPage(), // Asumiendo que tienes una SearchPage
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
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
        ],
        currentIndex: _selectedIndex,
        backgroundColor: Colors.grey[800], // Fondo gris del BottomNavigationBar
        selectedItemColor: Colors.white, // Color del ítem seleccionado
        unselectedItemColor: Colors.grey[400], // Color del ítem no seleccionado
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final List<String> albumImages = [
    'https://melomix.s3.us-east-2.amazonaws.com/img/img1.jpg',
    'https://melomix.s3.us-east-2.amazonaws.com/img/img2.jpg',
    'https://melomix.s3.us-east-2.amazonaws.com/img/img3.jpg',
    'https://melomix.s3.us-east-2.amazonaws.com/img/img4.jpg',
    'https://melomix.s3.us-east-2.amazonaws.com/img/img5.jpg',
    'https://melomix.s3.us-east-2.amazonaws.com/img/img6.jpg',
    'https://melomix.s3.us-east-2.amazonaws.com/img/img7.jpg',
    'https://melomix.s3.us-east-2.amazonaws.com/img/img8.jpg',
    'https://melomix.s3.us-east-2.amazonaws.com/img/img9.jpg',
    'https://melomix.s3.us-east-2.amazonaws.com/img/img10.jpg',
    'https://melomix.s3.us-east-2.amazonaws.com/img/img11.jpg',
    'https://melomix.s3.us-east-2.amazonaws.com/img/img12.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 250.0,
          flexibleSpace: FlexibleSpaceBar(
            title: Text('Good Morning'),
            background: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  'https://melomix.s3.us-east-2.amazonaws.com/img/img7.jpg',
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.error, color: Colors.red);
                  },
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.6),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          pinned: true,
          actions: [
            IconButton(
              icon: Icon(Icons.person_add),
              onPressed: () {
                Get.toNamed(AppRoutes.login); // Navega a la pantalla de login
              },
            ),
          ],
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Featured Playlist',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 16.0),
                CarouselSlider.builder(
                  itemCount: albumImages.length,
                  itemBuilder: (context, index, realIndex) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          albumImages[index],
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.error, color: Colors.red);
                          },
                        ),
                      ),
                    );
                  },
                  options: CarouselOptions(
                    height: 220,
                    viewportFraction: 0.3,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    scrollDirection: Axis.horizontal,
                    enlargeStrategy: CenterPageEnlargeStrategy.scale,
                    enableInfiniteScroll: true,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Recently Played',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(68.0),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              crossAxisSpacing: 28.0,
              mainAxisSpacing: 48.0,
            ),
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return Column(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(9.0),
                        child: Image.network(
                          albumImages[index % albumImages.length],
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.error, color: Colors.red);
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Album ${index + 1}',
                      style: TextStyle(fontSize: 16.0, color: Colors.white),
                    ),
                  ],
                );
              },
              childCount: 10,
            ),
          ),
        ),
      ],
    );
  }
}

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Search Page'),
    );
  }
}