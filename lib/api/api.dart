import 'dart:convert';

import '../api/constants.dart';
import 'package:http/http.dart' as http;
import '../model/movie_model.dart';
import 'dart:convert';

class Api {
  // final searchApiUrl = "https://api.themoviedb.org/3/movie/search?api_key=$apiKey2&query=$query";
  //final nowPlayingUrl = "https://api.themoviedb.org/3/movie/nowplaying?api_key=$apiKey";
  final upComingApiUrl = "https://api.themoviedb.org/3/movie/upcoming?api_key=$apiKey";
  final popularApiUrl = "https://api.themoviedb.org/3/movie/popular?api_key=$apiKey";
  final topRatedApiUrl = "https://api.themoviedb.org/3/movie/top_rated?api_key=$apiKey";


  Future<List<Movie>> getSearchMovies(String query) async {
    final response = await http.get(Uri.parse("https://api.themoviedb.org/3/movie/search?api_key=$apiKey2&query=$query"));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];

      List<Movie> movies = data.map((movie) => Movie.fromMap(movie)).toList();
      return movies;
    } else {
      throw Exception('Failed to load movies');
    }
  }



  Future<List<Movie>> getUpcomingMovies() async {
    final response = await http.get(Uri.parse(upComingApiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];

      List<Movie> movies = data.map((movie) => Movie.fromMap(movie)).toList();
      return movies;
    } else {
      throw Exception('Failed to load upcoming movies');
    }
  }

  // Future<List<Movie>> getNowPlayingMovies() async {
  //   final response = await http.get(Uri.parse(nowPlayingUrl));
  //
  //   if(response.statusCode == 200) {
  //     final List<dynamic> data = json.decode(response.body)['results'];
  //
  //     List<Movie> movies = data.map((movie) => Movie.fromMap(movie)).toList();
  //     return movies;
  //   }else{
  //     throw Exception("Failed to load nowplaying movies");
  //   }
  //
  // }


  Future<List<Movie>> getPopularMovies() async {
    final response = await http.get(Uri.parse(popularApiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];

      List<Movie> movies = data.map((movie) => Movie.fromMap(movie)).toList();
      return movies;
    } else {
      throw Exception('Failed to load popular movies');
    }
  }

  Future<List<Movie>> getTopRatedMovies() async {
    final response = await http.get(Uri.parse(topRatedApiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];

      List<Movie> movies = data.map((movie) => Movie.fromMap(movie)).toList();
      return movies;
    } else {
      throw Exception('Failed to load top rated movies');
    }
  }
}

