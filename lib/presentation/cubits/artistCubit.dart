import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melomix/cubit/artist_cubit.dart';
import 'package:melomix/services/api_services.dart';
import 'package:melomix/config/config.dart';
import 'package:melomix/ui/artist_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Melomix',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => ArtistCubit(artistServices: ApiServices()),
        child: ArtistScreen(),
      ),
    );
  }
}