import 'package:flutter/material.dart';
import 'package:melomix/data/model/artist.dart';
import 'package:melomix/data/repository/artist_repository.dart';

class ArtistScreen extends StatefulWidget {
  @override
  _ArtistScreenState createState() => _ArtistScreenState();
}

class _ArtistScreenState extends State<ArtistScreen> {
  late ArtistRepository artistRepository;
  late Future<List<Artist>> artistsFuture;

  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _genre = '';
  String _bio = '';

  @override
  void initState() {
    super.initState();
    artistRepository = ArtistRepository(apiUrl: 'https://iubl4o2scl.execute-api.us-east-2.amazonaws.com/Prod');
    _fetchArtists();
  }

  void _fetchArtists() {
    setState(() {
      artistsFuture = artistRepository.getAllArtists();
    });
  }

  void _addArtist() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final newArtist = Artist(
        artistId: 0, // El backend debería generar el ID automáticamente
        name: _name,
        genre: _genre,
        bio: _bio,
      );
      await artistRepository.createArtist(newArtist);
      _fetchArtists(); // Refresca la lista de artistas después de agregar uno nuevo

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Artist added successfully')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Artists Management'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
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
                    onPressed: _addArtist,
                    child: Text('Add Artist'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<Artist>>(
                future: artistsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No artists found'));
                  } else {
                    final artists = snapshot.data!;
                    return ListView.builder(
                      itemCount: artists.length,
                      itemBuilder: (context, index) {
                        final artist = artists[index];
                        return ListTile(
                          title: Text(artist.name),
                          subtitle: Text('${artist.genre} - ${artist.bio}'),
                        );
                      },
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