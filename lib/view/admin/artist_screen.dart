import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melomix/data/model/artist.dart';
import 'package:melomix/presentation/cubits/artistCubit.dart';
import 'package:melomix/presentation/cubits/artistState.dart';

class ArtistScreen extends StatefulWidget {
  @override
  _ArtistScreenState createState() => _ArtistScreenState();
}

class _ArtistScreenState extends State<ArtistScreen> {
  @override
  void initState() {
    super.initState();
    // Cargar los artistas al iniciar la pantalla
    context.read<ArtistCubit>().loadArtists();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Artists'),
        centerTitle: true,
        backgroundColor: Colors.grey[900],
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showAddArtistModal(context);
            },
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: BlocBuilder<ArtistCubit, ArtistState>(
        builder: (context, state) {
          if (state is ArtistLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ArtistSuccess) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // Cuatro columnas
                crossAxisSpacing: 10, // Espacio entre columnas
                mainAxisSpacing: 10, // Espacio entre filas
                childAspectRatio: 3 / 4, // Relación de aspecto de las tarjetas
              ),
              padding: const EdgeInsets.all(16),
              itemCount: state.artists.length,
              itemBuilder: (context, index) {
                final artist = state.artists[index];
                return Card(
                  color: Colors.grey[850],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: InkWell(
                    onTap: () {
                      // Puedes agregar navegación a una pantalla de detalles o edición
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Center(
                              child: Text(
                                artist.name,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Genre: ${artist.genre}',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.white),
                                onPressed: () {
                                  _showEditArtistModal(context, artist);
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  _showDeleteConfirmationModal(context, artist);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is ArtistError) {
            return Center(
              child: Text(
                'Failed to load artists: ${state.message}',
                style: TextStyle(color: Colors.red),
              ),
            );
          } else {
            return Center(
              child: Text(
                'No artists available',
                style: TextStyle(color: Colors.white),
              ),
            );
          }
        },
      ),
    );
  }

  void _showAddArtistModal(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController genreController = TextEditingController();
    TextEditingController bioController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.grey[850],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (context) {
        bool isFormValid = nameController.text.isNotEmpty &&
            genreController.text.isNotEmpty;

        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 16,
            left: 16,
            right: 16,
          ),
          child: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white70),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                    onChanged: (_) {
                      setState(() {
                        isFormValid = nameController.text.isNotEmpty &&
                            genreController.text.isNotEmpty;
                      });
                    },
                  ),
                  TextField(
                    controller: genreController,
                    decoration: InputDecoration(
                      labelText: 'Genre',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white70),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                    onChanged: (_) {
                      setState(() {
                        isFormValid = nameController.text.isNotEmpty &&
                            genreController.text.isNotEmpty;
                      });
                    },
                  ),
                  TextField(
                    controller: bioController,
                    decoration: InputDecoration(
                      labelText: 'Bio',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white70),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Cancelar',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      SizedBox(width: 8),
                      TextButton(
                        onPressed: isFormValid
                            ? () {
                                Navigator.of(context).pop();
                                _showConfirmationModal(
                                  context,
                                  nameController.text,
                                  genreController.text,
                                  bioController.text,
                                );
                              }
                            : null,
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            isFormValid ? Colors.green : Colors.green[900],
                          ),
                          foregroundColor: MaterialStateProperty.all(
                            Colors.white,
                          ),
                        ),
                        child: Text('Aceptar'),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  void _showEditArtistModal(BuildContext context, Artist artist) {
    TextEditingController nameController = TextEditingController(text: artist.name);
    TextEditingController genreController = TextEditingController(text: artist.genre);
    TextEditingController bioController = TextEditingController(text: artist.bio ?? '');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.grey[850],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (context) {
        bool isFormValid = nameController.text.isNotEmpty &&
            genreController.text.isNotEmpty;

        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 16,
            left: 16,
            right: 16,
          ),
          child: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white70),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                    onChanged: (_) {
                      setState(() {
                        isFormValid = nameController.text.isNotEmpty &&
                            genreController.text.isNotEmpty;
                      });
                    },
                  ),
                  TextField(
                    controller: genreController,
                    decoration: InputDecoration(
                      labelText: 'Genre',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white70),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                    onChanged: (_) {
                      setState(() {
                        isFormValid = nameController.text.isNotEmpty &&
                            genreController.text.isNotEmpty;
                      });
                    },
                  ),
                  TextField(
                    controller: bioController,
                    decoration: InputDecoration(
                      labelText: 'Bio',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white70),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Cancelar',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      SizedBox(width: 8),
                      TextButton(
                        onPressed: isFormValid
                            ? () {
                                Navigator.of(context).pop();
                                _updateArtist(
                                  context,
                                  artist.artistId!,
                                  nameController.text,
                                  genreController.text,
                                  bioController.text,
                                );
                              }
                            : null,
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            isFormValid ? Colors.green : Colors.green[900],
                          ),
                          foregroundColor: MaterialStateProperty.all(
                            Colors.white,
                          ),
                        ),
                        child: Text('Aceptar'),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  void _showDeleteConfirmationModal(BuildContext context, Artist artist) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey[850],
          title: Text(
            'Confirmación',
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            '¿Estás seguro de que quieres eliminar a ${artist.name}?',
            style: TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancelar',
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (artist.artistId != null) {
                  context.read<ArtistCubit>().deleteArtist(artist.artistId!);
                }
              },
              child: Text(
                'Eliminar',
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        );
      },
    );
  }

  void _updateArtist(BuildContext context, int artistId, String name, String genre, String? bio) {
    context.read<ArtistCubit>().updateArtist(
      Artist(
        artistId: artistId,
        name: name,
        genre: genre,
        bio: bio,
      ),
    );
  }

  void _showConfirmationModal(
    BuildContext context,
    String name,
    String genre,
    String? bio,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 134, 132, 132),
          title: Text(
            'Confirmación',
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            '¿Estás seguro de que deseas agregar a $name?',
            style: TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancelar',
                style: TextStyle(color: const Color.fromARGB(255, 145, 92, 88)),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.read<ArtistCubit>().createArtist(
                  Artist(
                    name: name,
                    genre: genre,
                    bio: bio,
                  ),
                );
              },
              child: Text(
                'Aceptar',
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        );
      },
    );
  }
}