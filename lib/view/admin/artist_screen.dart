import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melomix/presentation/cubits/artistCubit.dart';
import 'package:melomix/presentation/cubits/artistState.dart';
import 'package:melomix/data/model/artist.dart';

class ArtistScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Artista'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocProvider(
          create: (context) => ArtistCubit(artistServices: ApiServices()), // Proveedor temporal del cubit
          child: CreateArtistForm(),
        ),
      ),
    );
  }
}

class CreateArtistForm extends StatefulWidget {
  @override
  _CreateArtistFormState createState() => _CreateArtistFormState();
}

class _CreateArtistFormState extends State<CreateArtistForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _genreController = TextEditingController();
  final _bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ArtistCubit, ArtistState>(
      listener: (context, state) {
        if (state is ArtistSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Artista creado con éxito')),
          );
          Navigator.pop(context); // Volver a la pantalla anterior
        } else if (state is ArtistError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${state.message}')),
          );
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el nombre';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _genreController,
                decoration: InputDecoration(labelText: 'Género'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el género';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _bioController,
                decoration: InputDecoration(labelText: 'Biografía (opcional)'),
              ),
              SizedBox(height: 20),
              state is ArtistLoading
                  ? Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          final artist = Artist(
                            artistId: 0,
                            name: _nameController.text,
                            genre: _genreController.text,
                            bio: _bioController.text,
                          );
                          BlocProvider.of<ArtistCubit>(context).createArtist(artist);
                        }
                      },
                      child: Text('Crear Artista'),
                    ),
            ],
          ),
        );
      },
    );
  }
}