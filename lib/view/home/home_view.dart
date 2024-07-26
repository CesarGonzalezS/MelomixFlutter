import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeView extends StatelessWidget {
  final List<String> albumImages = [
    'assets/img/music1.png',
    'assets/img/music2.png',
    'assets/img/music3.png',
    'assets/img/music4.png',
    'assets/img/music5.png',
    'assets/img/music6.png',
    'assets/img/music8.png',

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Good Morning'),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/img/music7.png',
                    fit: BoxFit.cover,
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
            actions: [
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  // Search action
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
                        margin: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            albumImages[index],
                            fit: BoxFit.cover,
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
                crossAxisCount: 4,
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
                          child: Image.asset(
                            albumImages[index % albumImages.length],
                            fit: BoxFit.cover,
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
                childCount: 8,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
