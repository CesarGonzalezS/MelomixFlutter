import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MelonMix',
      theme: ThemeData.dark(),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Genre> genres = [];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();
  int _currentIndex = 0;

  // Datos de favoritos
  final List<FavoriteItem> favorites = const [
    FavoriteItem('Lolo Zouaï', 'Artist', 'assets/lolo_zouai.jpg'),
    FavoriteItem('Lana Del Rey', 'Artist', 'assets/lana_del_rey.jpg'),
    FavoriteItem('Front Left', 'Playlist', 'assets/front_left.jpg'),
    FavoriteItem('Marvin Gaye', 'Artist', 'assets/marvin_gaye.jpg'),
  ];

  // Función para agregar un nuevo género
  void _addGenre() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Agregar Género'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nombre'),
              ),
              TextField(
                controller: _urlController,
                decoration: const InputDecoration(labelText: 'URL de la Imagen'),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Agregar'),
              onPressed: () {
                setState(() {
                  if (_urlController.text.isNotEmpty && _nameController.text.isNotEmpty) {
                    genres.add(Genre(_nameController.text, _urlController.text));
                    _nameController.clear();
                    _urlController.clear();
                  }
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Función para editar un género existente
  void _editGenre(int index) {
    _nameController.text = genres[index].name;
    _urlController.text = genres[index].imageUrl;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Editar Género'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nombre'),
              ),
              TextField(
                controller: _urlController,
                decoration: const InputDecoration(labelText: 'URL de la Imagen'),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Guardar'),
              onPressed: () {
                setState(() {
                  genres[index] = Genre(_nameController.text, _urlController.text);
                  _nameController.clear();
                  _urlController.clear();
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Función para eliminar un género
  void _deleteGenre(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar Eliminación'),
          content: const Text('¿Estás seguro de que quieres eliminar la categoría?'),
          actions: [
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Eliminar'),
              onPressed: () {
                setState(() {
                  genres.removeAt(index);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Función para construir la lista de géneros
  Widget _buildGenresList() {
    return Row(
      children: [
        const Spacer(),
        Expanded(
          flex: 8,
          child: ListView.builder(
            itemCount: genres.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: Key(genres[index].name),
                onDismissed: (direction) {
                  setState(() {
                    genres.removeAt(index);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${genres[index].name} eliminado')),
                  );
                },
                background: Container(color: Colors.red),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(genres[index].imageUrl),
                  ),
                  title: Text(genres[index].name),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _editGenre(index),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _deleteGenre(index),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const Spacer(),
      ],
    );
  }

  // Función para construir la lista de favoritos
  Widget _buildFavoritesList() {
    return ListView.builder(
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(favorites[index].imageUrl),
          ),
          title: Text(favorites[index].title),
          subtitle: Text(favorites[index].subtitle),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MelonMix'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addGenre,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      _currentIndex = 0;
                    });
                  },
                  child: const Text('Géneros'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _currentIndex = 1;
                    });
                  },
                  child: const Text('Favoritos'),
                ),
              ],
            ),
          ),
          Expanded(
            child: _currentIndex == 0 ? _buildGenresList() : _buildFavoritesList(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Buscador',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class Genre {
  final String name;
  final String imageUrl;

  Genre(this.name, this.imageUrl);
}

class FavoriteItem {
  final String title;
  final String subtitle;
  final String imageUrl;

  const FavoriteItem(this.title, this.subtitle, this.imageUrl);
}
