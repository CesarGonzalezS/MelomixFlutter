import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melomix/routes.dart';
import 'package:melomix/presentation/cubits/album/albumCubit.dart';
import 'package:melomix/presentation/cubits/album/albumState.dart';
import 'package:melomix/presentation/cubits/song_cubit.dart';
import 'package:melomix/presentation/cubits/song_state.dart';
import 'package:melomix/services/api_services.dart';

class HomeView extends StatelessWidget {
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

  final List<String> songImages = [
    'https://melomix.s3.us-east-2.amazonaws.com/img_songs/musica1.jpg',
    'https://melomix.s3.us-east-2.amazonaws.com/img_songs/musica2.jpg',
    'https://melomix.s3.us-east-2.amazonaws.com/img_songs/musica3.jpg',
    'https://melomix.s3.us-east-2.amazonaws.com/img_songs/musica4.jpg',
    'https://melomix.s3.us-east-2.amazonaws.com/img_songs/musica5.jpg',
    'https://melomix.s3.us-east-2.amazonaws.com/img_songs/musica6.jpg',
    'https://melomix.s3.us-east-2.amazonaws.com/img_songs/musica7.jpg',
    'https://melomix.s3.us-east-2.amazonaws.com/img_songs/musica8.jpg',
    'https://melomix.s3.us-east-2.amazonaws.com/img_songs/music8.jpg',
    'https://melomix.s3.us-east-2.amazonaws.com/img_songs/musica10.jpg',
    'https://melomix.s3.us-east-2.amazonaws.com/img_songs/musica11.jpg',
    'https://melomix.s3.us-east-2.amazonaws.com/img_songs/musica12.jpg',
    'https://melomix.s3.us-east-2.amazonaws.com/img_songs/musica13.jpg',
    'https://melomix.s3.us-east-2.amazonaws.com/img_songs/musica14.jpg',
    'https://melomix.s3.us-east-2.amazonaws.com/img_songs/musica15.jpg',
    'https://melomix.s3.us-east-2.amazonaws.com/img_songs/musica17.jpg',
    'https://melomix.s3.us-east-2.amazonaws.com/img_songs/musica18.jpg',
    'https://melomix.s3.us-east-2.amazonaws.com/img_songs/musica19.jpg',
    'https://melomix.s3.us-east-2.amazonaws.com/img_songs/musica20.jpg',
  ];

  HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AlbumCubit(apiServices: ApiServices())..loadAlbums(),
        ),
        BlocProvider(
          create: (context) => SongCubit(apiServices: ApiServices())..getAllSongs(),
        ),
      ],
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 250.0,
              flexibleSpace: FlexibleSpaceBar(
                title: Text('MeloMix'),
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 16.0),
                    Text(
                      'Bienvenido a MelonMix',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Explora el mejor buscador de las canciones mas escuchadas en el mundo',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white70,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 32.0),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Canciones favoritas del momento',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    BlocBuilder<SongCubit, SongState>(
                      builder: (context, state) {
                        if (state is SongLoading) {
                          return Center(child: CircularProgressIndicator());
                        } else if (state is SongSuccess) {
                          return CarouselSlider.builder(
                            itemCount: state.songs.length,
                            itemBuilder: (context, index, realIndex) {
                              final song = state.songs[index];
                              return Container(
                                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Image.network(
                                          songImages[index % songImages.length],
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: 250, // Ajuste de altura para hacer las canciones más largas
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
                                      SizedBox(height: 8),
                                      Text(
                                        song.title,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                      Text(
                                        'Duración: ${song.duration} ',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white70,
                                        ),
                                      ),
                                      Text(
                                        'El género es: ${song.genre}',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white70,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            options: CarouselOptions(
                              height: 260, // Altura del carrusel ajustada para canciones más largas
                              viewportFraction: 0.3,
                              enlargeCenterPage: true,
                              autoPlay: true,
                              autoPlayInterval: Duration(seconds: 3),
                              autoPlayAnimationDuration: Duration(milliseconds: 800),
                              scrollDirection: Axis.horizontal,
                              enlargeStrategy: CenterPageEnlargeStrategy.scale,
                              enableInfiniteScroll: true,
                            ),
                          );
                        } else if (state is SongError) {
                          return Center(
                            child: Text(
                              'Error al cargar las canciones: ${state.message}',
                              style: TextStyle(color: Colors.red),
                            ),
                          );
                        } else {
                          return Center(
                            child: Text(
                              'No hay canciones disponibles.',
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        }
                      },
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Los álbumes disponibles mas conocidos',
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
                        crossAxisCount: 4, // Mostrar 4 tarjetas por fila
                        crossAxisSpacing: 12.0,
                        mainAxisSpacing: 12.0,
                        childAspectRatio: 1 / 1.5, // Relación de aspecto ajustada para tarjetas más pequeñas
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
                                        child: Image.network(
                                          albumImages[index % albumImages.length], // Cargar imágenes desde AWS
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      album.title,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12, // Tamaño de texto más pequeño
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      'Se creó el: ${album.releaseDate.toLocal().toString().split(' ')[0]}',
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        childCount: albums.length > 8 ? 8 : albums.length, // Mostrar solo 8 álbumes
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
            // Footer bonito
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 32.0),
                child: Column(
                  children: [
                    Text(
                      'MelonMix',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'El mejor gestor de música a tu alcance. Registrate y pruebala!',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16),
                    Text(
                      '© 2024 MelonMix. Todos los derechos reservados.',
                      style: TextStyle(
                        color: Colors.white38,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
