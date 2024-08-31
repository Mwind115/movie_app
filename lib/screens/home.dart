import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_v2/screens/detail_movie.dart';
import '../api/api.dart';
import '../api/constants.dart';
import '../model/movie_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});


  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  bool _isSearching = false; // State variable to toggle search bar visibility
  TextEditingController _searchController = TextEditingController();
  List<Movie> _movies =[];
  final Api _api = Api();
  bool _isLoading = false;
  bool _isLoadingSearch = false;


  late Future<List<Movie>> searchMovies;
  //late Future<List<Movie>> nowPlayingMovie;
  late Future<List<Movie>> upcomingMovies;
  late Future<List<Movie>> popularMovies;
  late Future<List<Movie>> topRatedMovies;

  @override
  void initState() {
    // searchMovies = Api().getSearchMovies();
    //nowPlayingMovie = Api().getNowPlayingMovies();
    upcomingMovies = Api().getUpcomingMovies();
    popularMovies = Api().getPopularMovies();
    topRatedMovies = Api().getTopRatedMovies();
    super.initState();
  }


  void _searchMovies(String query) async {
    setState(() {
      _isLoadingSearch = true;
    });
    try {
      final movies = await _api.getSearchMovies(query);
      setState(() {
        _movies = movies;
      });
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        _isLoadingSearch = false;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xff3A3F47)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              TextButton(
                  onPressed: (){},
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.amber,
                    ),
                    width: double.infinity,
                    height: 50,
                    child: Center(
                        child: Text("Upcoming", style: TextStyle01)
                    ),
                  )
              ),

              TextButton(
                  onPressed: (){},
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.amber,
                    ),
                    width: double.infinity,
                    height: 50,
                    child: Center(
                        child: Text("Upcoming", style: TextStyle01)
                    ),
                  )
              ),

              TextButton(
                  onPressed: (){},
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.amber,
                    ),
                    width: double.infinity,
                    height: 50,
                    child: Center(
                        child: Text("Upcoming", style: TextStyle01)
                    ),
                  )
              ),

            ],
          ),
        ),
      ),
      backgroundColor: Color(0xff242A32),
      appBar: AppBar(
        backgroundColor: Colors.black12,
        foregroundColor: Colors.white,
        //leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
        title: _isSearching ? _buildSearchField() : Text("Movie App"),
        centerTitle: true,
        actions: _buildActions(),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _isLoadingSearch ? _bodySearch() : _bodyApp()
    );
  }

  // Widget _topRateInk() {
  //   return InkWell(
  //     child: Image.network(
  //       "https://image.tmdb.org/t/p/original/${}",
  //       height: 120,
  //       width: double.infinity,
  //       fit: BoxFit.cover,
  //     ),
  //   )
  // }


  Widget _bodySearch() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 5.0,
      ),
      itemCount: _movies.length,
      itemBuilder: (context, index) {
        final movie = _movies[index];
        return GridTile(
          child: Image.network(
            'https://image.tmdb.org/t/p/w500${movie.backDropPath}',
            fit: BoxFit.cover,
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black54,
            title: Text(movie.title),
          ),
        );
      },
    );
  }


  Widget _bodyApp() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Upcoming',
              style: TextStyle01,
            ),
            //Carousel
            FutureBuilder(
              future: upcomingMovies,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final movies = snapshot.data!;

                return CarouselSlider.builder(
                  itemCount: movies.length,
                  itemBuilder: (context, index, movieIndex) {
                    final movie = movies[index];
                    return Container(
                      width: double.infinity,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                      child: InkWell(
                          onTap: (){
                            Navigator.pushNamedAndRemoveUntil(context, '/d',(route) => route.isFirst, arguments: movie);
                          },
                          child: Image.network("https://image.tmdb.org/t/p/original/${movie.backDropPath}")
                      ),
                    );
                  },
                  options: CarouselOptions(
                      autoPlay: true,
                      enlargeCenterPage: true,
                      aspectRatio: 1.4,
                      autoPlayInterval: const Duration(seconds: 3)),
                );
              },
            ),


            // const Text(
            //   'Now Playing',
            //   style: TextStyle(color: Colors.white),
            // ),
            // Container(
            //   margin: const EdgeInsets.symmetric(vertical: 20),
            //   height: 200,
            //   child: FutureBuilder(
            //     future: nowPlayingMovie,
            //     builder: (context, snapshot) {
            //       if (!snapshot.hasData) {
            //         return const Center(
            //           child: CircularProgressIndicator(),
            //         );
            //       }
            //
            //       final movies = snapshot.data!;
            //       return ListView.builder(
            //         scrollDirection: Axis.horizontal,
            //         itemCount: movies.length,
            //         itemBuilder: (context, index) {
            //           final movie = movies[index];
            //
            //           return Container(
            //             width: 150,
            //             margin: const EdgeInsets.symmetric(horizontal: 10),
            //             decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
            //             child: ClipRRect(
            //               borderRadius: BorderRadius.circular(15),
            //               child: Image.network(
            //                 "https://image.tmdb.org/t/p/original/${movie.backDropPath}",
            //                 height: 120,
            //                 width: double.infinity,
            //                 fit: BoxFit.cover,
            //               ),
            //             ),
            //           );
            //         },
            //       );
            //     },
            //   ),
            // ),

            //Popular Movies
            Text(
              'Popular',
              style: TextStyle01,
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              height: 200,
              child: FutureBuilder(
                future: popularMovies,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final movies = snapshot.data!;
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: movies.length,
                    itemBuilder: (context, index) {
                      final movie = movies[index];

                      return Container(
                        width: 150,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: InkWell(
                            onTap: (){
                              Navigator.pushNamedAndRemoveUntil(context, '/d',(route) => route.isFirst, arguments: movie);
                            },
                            child: Image.network(
                              "https://image.tmdb.org/t/p/original/${movie.backDropPath}",
                              height: 120,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),

            Text(
              'Top Rated',
              style: TextStyle01,
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              height: 200,
              child: FutureBuilder(
                future: topRatedMovies,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final movies = snapshot.data!;
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: movies.length,
                    itemBuilder: (context, index) {
                      final movie = movies[index];

                      return Container(
                        width: 150,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: InkWell(
                            onTap: (){
                              Navigator.pushNamedAndRemoveUntil(context, '/d',(route) => route.isFirst, arguments: movie);
                            },
                            child: Image.network(
                              "https://image.tmdb.org/t/p/original/${movie.backDropPath}",
                              height: 120,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      autofocus: true,
      decoration: InputDecoration(
        hintText: 'Search movies...',
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white54),
      ),
      style: TextStyle(color: Colors.white, fontSize: 16.0),
      onSubmitted: _searchMovies,
    );
  }

  List<Widget> _buildActions() {
    if (_isSearching) {
      return [
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            setState(() {
              _isSearching = false;
              _searchController.clear();
            });
          },
        ),
      ];
    } else {
      return [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            setState(() {
              _isSearching = true;
            });
          },
        ),
      ];
    }
  }


}

