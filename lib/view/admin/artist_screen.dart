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
  // Definir un GlobalKey para el ScaffoldMessenger
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    // Cargar los artistas al iniciar la pantalla
    context.read<ArtistCubit>().loadArtists();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldMessengerKey,  // Asociar el GlobalKey con el Scaffold
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
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 16,
                  columns: const [
                    DataColumn(label: Text('Artist')),
                    DataColumn(label: Text('Genre')),
                  ],
                  rows: state.artists.map((artist) {
                    return DataRow(
                      cells: [
                        DataCell(Text(
                          artist.name,
                          style: TextStyle(color: Colors.white),
                        )),
                        DataCell(Text(
                          artist.genre,
                          style: TextStyle(color: Colors.grey),
                        )),
                      ],
                    );
                  }).toList(),
                ),
              ),
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
        return StatefulBuilder(
          builder: (context, setState) {
            bool isFormValid = nameController.text.isNotEmpty &&
                genreController.text.isNotEmpty;

            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                top: 16,
                left: 16,
                right: 16,
              ),
              child: Column(
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
                      labelText: 'Bio (optional)',
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
                          'Cancel',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      SizedBox(width: 8),
                      TextButton(
                        onPressed: isFormValid
                            ? () async {
                                Navigator.of(context).pop();
                                await _addArtist(
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
                        child: Text('Add'),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _addArtist(BuildContext context, String name, String genre, String bio) async {
    final newArtist = Artist(
      artistId: '', // Usar cadena vacía en lugar de 0
      name: name,
      genre: genre,
      bio: bio,
    );

    try {
      await context.read<ArtistCubit>().createArtist(newArtist);

      // Verificar si el widget está montado antes de mostrar el SnackBar
      if (mounted) {
        scaffoldMessengerKey.currentState?.showSnackBar(
          SnackBar(
            content: Text('Artist created successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        scaffoldMessengerKey.currentState?.showSnackBar(
          SnackBar(
            content: Text('Failed to create artist: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}