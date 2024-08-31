import 'package:flutter/material.dart';
import 'package:movie_app_v2/screens/detail_movie.dart';

import 'screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

      routes: {
        '/h' : (context) => const Home(),
        '/d' : (context) => const DetailMovie(),
      },
      home: Home(),
    );
  }
}
