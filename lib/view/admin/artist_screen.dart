// lib/view/admin/artist_screen.dart
import 'package:flutter/material.dart';
import 'package:melomix/data/model/artist.dart';
import 'package:melomix/data/repository/artist_repository.dart';
import 'package:melomix/presentation/cubits/artistCubit.dart';


class ArtistScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ArtistCubit(
        artistRepository: ArtistRepository(apiUrl: 'https://iubl4o2scl.execute-api.us-east-2.amazonaws.com/Prod'),
      )..fetchArtists(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Artists Management'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              AddArtistForm(),
              SizedBox(height: 20),
              Expanded(
                child: BlocBuilder<ArtistCubit, ArtistState>(
                  builder: (context, state) {
                    if (state is ArtistLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is ArtistError) {
                      return Center(child: Text('Error: ${state.message}'));
                    } else if (state is ArtistLoaded) {
                      final artists = state.artists;
                      return ListView.builder(
                        itemCount: artists.length,
                        itemBuilder: (context, index) {
                          final artist = artists[index];
                          return ListTile(
                            title: Text(artist.name),
                            subtitle: Text('${artist.genre} - ${artist.bio}'),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                BlocProvider.of<ArtistCubit>(context)
                                    .deleteArtist(artist.artistId);
                              },
                            ),
                            onTap: () {
                              // Aquí puedes agregar la funcionalidad para actualizar un artista
                            },
                          );
                        },
                      );
                    } else {
                      return Center(child: Text('No artists found'));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddArtistForm extends StatefulWidget {
  @override
  _AddArtistFormState createState() => _AddArtistFormState();
}

class _AddArtistFormState extends State<AddArtistForm> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _genre = '';
  String _bio = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: 'Name'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a name';
              }
              return null;
            },
            onSaved: (value) {
              _name = value!;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Genre'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a genre';
              }
              return null;
            },
            onSaved: (value) {
              _genre = value!;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Bio'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a bio';
              }
              return null;
            },
            onSaved: (value) {
              _bio = value!;
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                final newArtist = Artist(
                  artistId: 0, // El backend debería generar el ID automáticamente
                  name: _name,
                  genre: _genre,
                  bio: _bio,
                );
                BlocProvider.of<ArtistCubit>(context).addArtist(newArtist);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Artist added successfully')),
                );
              }
            },
            child: Text('Add Artist'),
          ),
        ],
      ),
    );
  }
}