import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melomix/services/api_services.dart';
import 'package:melomix/presentation/cubits/song_cubit.dart';
import 'package:melomix/presentation/cubits/song_state.dart';

class DeleteSongScreen extends StatefulWidget {
  @override
  _DeleteSongScreenState createState() => _DeleteSongScreenState();
}

class _DeleteSongScreenState extends State<DeleteSongScreen> {
  final TextEditingController _idController = TextEditingController();
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delete Song'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Enter the ID of the song to delete:'),
            TextField(
              controller: _idController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Song ID',
              ),
            ),
            SizedBox(height: 16.0),
            if (_errorMessage.isNotEmpty) 
              Text(_errorMessage, style: TextStyle(color: Colors.red)),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _deleteSong(context);
              },
              child: Text('Delete Song'),
            ),
          ],
        ),
      ),
    );
  }

  void _deleteSong(BuildContext context) {
    final songId = _idController.text.trim();

    if (songId.isEmpty) {
      setState(() {
        _errorMessage = 'Song ID cannot be empty';
      });
      return;
    }

    context.read<SongCubit>().deleteSong(songId);
    
    // Optionally, handle success or failure
    context.read<SongCubit>().stream.listen((state) {
      if (state is SongSuccess) {
        Navigator.pop(context); // Go back to previous screen
      } else if (state is SongError) {
        setState(() {
          _errorMessage = state.message;
        });
      }
    });
  }
}
