import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melomix/routes.dart';
import 'package:melomix/presentation/cubits/album/albumCubit.dart';
import 'package:melomix/presentation/cubits/album/albumState.dart';
import 'package:melomix/services/api_services.dart';

class HomeView extends StatelessWidget {
  final List<String> albumImages = [
    'assets/img/music3.jpg',
    'assets/img/music1.png',
    'assets/img/music2.png',
    'assets/img/music4.png',
    'assets/img/music5.png',
  ];

  HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AlbumCubit(apiServices: ApiServices())..loadAlbums(),
      child: Scaffold(
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
            // Sección para mostrar las tarjetas de álbumes
            SliverPadding(
              padding: const EdgeInsets.all(16.0),
              sliver: BlocBuilder<AlbumCubit, AlbumState>(
                builder: (context, state) {
                  if (state is AlbumLoading) {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (state is AlbumSuccess) {
                    final albums = state.albums;
                    if (albums.isEmpty) {
                      return SliverToBoxAdapter(
                        child: Center(
                          child: Text(
                            'No hay álbumes disponibles.',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    }
                    return SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, // Número de columnas en la cuadrícula (Ajuste de tamaño)
                        crossAxisSpacing: 12.0,
                        mainAxisSpacing: 12.0,
                        childAspectRatio: 2 / 3, // Relación de aspecto más pequeña
                      ),
                      delegate: SliverChildBuilderDelegate(
                            (context, index) {
                          final album = albums[index];
                          return Card(
                            color: Colors.grey[850],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: InkWell(
                              onTap: () {
                                // Acción al tocar la tarjeta del álbum
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10.0),
                                        child: Image.asset(
                                          'assets/img/default_album.png', // Imagen por defecto del álbum
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                        ),
                                        // Aquí es donde cargarás las imágenes desde AWS
                                        // Ejemplo: Image.network(album.imageUrl, ...)
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      album.title,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14, // Tamaño de texto reducido
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      'Release Date: ${album.releaseDate.toLocal().toString().split(' ')[0]}',
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        childCount: albums.length,
                      ),
                    );
                  } else if (state is AlbumError) {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Text(
                          'Error al cargar los álbumes: ${state.message}',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    );
                  } else {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Text(
                          'Estado desconocido.',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
