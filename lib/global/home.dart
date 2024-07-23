import 'package:flutter/material.dart';

void main() {
  runApp(MelonMixHome());
}

class MelonMixHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spotify Home',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              Text(
                'Good Evening',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              _buildCategory('Recently Played', [
                'assets/liked_songs.png',
                'assets/discover_weekly.png',
                'assets/top_50_global.png',
              ]),
              _buildCategory('Made for You', [
                'assets/playlist_1.png',
                'assets/playlist_2.png',
                'assets/playlist_3.png',
              ]),
              _buildCategory('Your Library', [
                'assets/album_1.png',
                'assets/album_2.png',
                'assets/album_3.png',
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategory(String title, List<String> imagePaths) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 10),
        Container(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: imagePaths.length,
            itemBuilder: (context, index) {
              return _buildPlaylistCard('Playlist ${index + 1}', imagePaths[index]);
            },
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildPlaylistCard(String title, String imagePath) {
    return Container(
      width: 100,
      margin: EdgeInsets.only(right: 10),
      child: Column(
        children: [
          Image.asset(imagePath, width: 100, height: 100),
          SizedBox(height: 5),
          Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 14),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
