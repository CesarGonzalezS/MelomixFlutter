import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melomix/data/model/albums.dart';
import 'package:melomix/presentation/cubits/album/albumCubit.dart';
import 'package:melomix/presentation/cubits/album/albumState.dart';

class AlbumScreen extends StatefulWidget {
  @override
  _AlbumScreenState createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  @override
  void initState() {
    super.initState();
    // Cargar los álbumes al iniciar la pantalla
    context.read<AlbumCubit>().loadAlbums();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Albums'),
        centerTitle: true,
        backgroundColor: Colors.grey[900],
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showAddAlbumModal(context);
            },
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: BlocBuilder<AlbumCubit, AlbumState>(
        builder: (context, state) {
          if (state is AlbumLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is AlbumSuccess) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // Cuatro columnas
                crossAxisSpacing: 10, // Espacio entre columnas
                mainAxisSpacing: 10, // Espacio entre filas
                childAspectRatio: 3 / 4, // Relación de aspecto de las tarjetas
              ),
              padding: const EdgeInsets.all(16),
              itemCount: state.albums.length,
              itemBuilder: (context, index) {
                final album = state.albums[index];
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
                                album.title,
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
                            'Release Date: ${album.releaseDate.toLocal()}',
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
                                  _showEditAlbumModal(context, album);
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  _showDeleteConfirmationModal(context, album);
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
          } else if (state is AlbumError) {
            return Center(
              child: Text(
                'Failed to load albums: ${state.message}',
                style: TextStyle(color: Colors.red),
              ),
            );
          } else {
            return Center(
              child: Text(
                'No albums available',
                style: TextStyle(color: Colors.white),
              ),
            );
          }
        },
      ),
    );
  }

  void _showAddAlbumModal(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController releaseDateController = TextEditingController();
    TextEditingController artistIdController = TextEditingController();

    Future<void> _selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
      );
      if (picked != null) {
        setState(() {
          releaseDateController.text = "${picked.toLocal()}".split(' ')[0];
        });
      }
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.grey[850],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (context) {
        bool isFormValid = titleController.text.isNotEmpty &&
            releaseDateController.text.isNotEmpty &&
            artistIdController.text.isNotEmpty;

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
                    controller: titleController,
                    decoration: InputDecoration(
                      labelText: 'Title',
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
                        isFormValid = titleController.text.isNotEmpty &&
                            releaseDateController.text.isNotEmpty &&
                            artistIdController.text.isNotEmpty;
                      });
                    },
                  ),
                  TextField(
                    controller: releaseDateController,
                    decoration: InputDecoration(
                      labelText: 'Release Date',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white70),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.calendar_today, color: Colors.white),
                        onPressed: () => _selectDate(context),
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                    readOnly: true, // Para que solo pueda seleccionar la fecha
                  ),
                  TextField(
                    controller: artistIdController,
                    decoration: InputDecoration(
                      labelText: 'Artist ID',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white70),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                    keyboardType: TextInputType.number,
                    onChanged: (_) {
                      setState(() {
                        isFormValid = titleController.text.isNotEmpty &&
                            releaseDateController.text.isNotEmpty &&
                            artistIdController.text.isNotEmpty;
                      });
                    },
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
                            titleController.text,
                            releaseDateController.text,
                            int.parse(artistIdController.text),
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

  void _showEditAlbumModal(BuildContext context, Album album) {
    TextEditingController titleController = TextEditingController(text: album.title);
    TextEditingController releaseDateController = TextEditingController(text: album.releaseDate.toIso8601String().split('T')[0]);
    TextEditingController artistIdController = TextEditingController(text: album.artistId.toString());

    Future<void> _selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: album.releaseDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
      );
      if (picked != null) {
        setState(() {
          releaseDateController.text = "${picked.toLocal()}".split(' ')[0];
        });
      }
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.grey[850],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (context) {
        bool isFormValid = titleController.text.isNotEmpty &&
            releaseDateController.text.isNotEmpty &&
            artistIdController.text.isNotEmpty;

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
                    controller: titleController,
                    decoration: InputDecoration(
                      labelText: 'Title',
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
                        isFormValid = titleController.text.isNotEmpty &&
                            releaseDateController.text.isNotEmpty &&
                            artistIdController.text.isNotEmpty;
                      });
                    },
                  ),
                  TextField(
                    controller: releaseDateController,
                    decoration: InputDecoration(
                      labelText: 'Release Date',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white70),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.calendar_today, color: Colors.white),
                        onPressed: () => _selectDate(context),
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                    readOnly: true, // Para que solo pueda seleccionar la fecha
                  ),
                  TextField(
                    controller: artistIdController,
                    decoration: InputDecoration(
                      labelText: 'Artist ID',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white70),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                    keyboardType: TextInputType.number,
                    onChanged: (_) {
                      setState(() {
                        isFormValid = titleController.text.isNotEmpty &&
                            releaseDateController.text.isNotEmpty &&
                            artistIdController.text.isNotEmpty;
                      });
                    },
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
                            titleController.text,
                            releaseDateController.text,
                            int.parse(artistIdController.text),
                            albumId: album.albumId,
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

  void _showDeleteConfirmationModal(BuildContext context, Album album) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("¿Estás seguro?"),
          content: Text("Estás a punto de eliminar el álbum: ${album.title}."),
          actions: [
            TextButton(
              child: Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Eliminar"),
              onPressed: () {
                Navigator.of(context).pop();
                _deleteAlbum(context, album.albumId);
              },
            ),
          ],
        );
      },
    );
  }

  void _showConfirmationModal(
      BuildContext context, String title, String releaseDate, int artistId, {int? albumId}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("¿Estás seguro?"),
          content: Text(albumId == null
              ? "Estás a punto de agregar este álbum: $title."
              : "Estás a punto de actualizar este álbum: $title."),
          actions: [
            TextButton(
              child: Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Sí"),
              onPressed: () {
                Navigator.of(context).pop();
                if (albumId == null) {
                  _addAlbum(context, title, releaseDate, artistId);
                } else {
                  _updateAlbum(context, albumId, title, releaseDate, artistId);
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _addAlbum(BuildContext context, String title, String releaseDate, int artistId) {
    final newAlbum = Album(
      albumId: 0, // Este campo puede ser ignorado si lo maneja el backend
      title: title,
      releaseDate: DateTime.parse(releaseDate),
      artistId: artistId,
    );

    context.read<AlbumCubit>().createAlbum(newAlbum);
  }

  void _updateAlbum(BuildContext context, int albumId, String title, String releaseDate, int artistId) {
    final updatedAlbum = Album(
      albumId: albumId,
      title: title,
      releaseDate: DateTime.parse(releaseDate),
      artistId: artistId,
    );

    context.read<AlbumCubit>().updateAlbum(updatedAlbum);
  }

  void _deleteAlbum(BuildContext context, int albumId) {
    context.read<AlbumCubit>().deleteAlbum(albumId);
  }
}