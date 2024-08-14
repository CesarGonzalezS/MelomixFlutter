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
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 16,
                  columns: const [
                    DataColumn(label: Text('Artist')),
                    DataColumn(label: Text('Genre')),
                    DataColumn(label: Text('Actions')),
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
                        DataCell(Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.blue),
                              onPressed: () {
                                _showEditArtistModal(context, artist);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                _showDeleteConfirmationDialog(context, artist);
                              },
                            ),
                          ],
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
                                await _editArtist(
                                  context,
                                  artist.copyWith(
                                    name: nameController.text,
                                    genre: genreController.text,
                                    bio: bioController.text,
                                  ),
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
                        child: Text('Update'),
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

  Future<void> _addArtist(
    BuildContext context,
    String name,
    String genre,
    String bio,
  ) async {
    final cubit = context.read<ArtistCubit>();
    try {
      await cubit.addArtist(name, genre, bio);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Artist added successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add artist: $e')),
      );
    }
  }

  Future<void> _editArtist(
    BuildContext context,
    Artist artist,
  ) async {
    final cubit = context.read<ArtistCubit>();
    try {
      await cubit.updateArtist(artist);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Artist updated successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update artist: $e')),
      );
    }
  }

  Future<void> _showDeleteConfirmationDialog(BuildContext context, Artist artist) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Artist'),
          content: Text('Are you sure you want to delete ${artist.name}?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                final cubit = context.read<ArtistCubit>();
                try {
                  await cubit.deleteArtist(artist.artistId);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Artist deleted successfully')),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to delete artist: $e')),
                  );
                }
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}