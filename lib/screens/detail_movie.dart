import 'package:flutter/material.dart';
import 'package:movie_app_v2/model/movie_model.dart';

import '../api/constants.dart';

class DetailMovie extends StatelessWidget {
  const DetailMovie({super.key});

  @override
  Widget build(BuildContext context) {

    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold(
        backgroundColor: Color(0xff242A32),
      appBar: AppBar(
        backgroundColor: Colors.black12,
        foregroundColor: Colors.white,
        title: Text(movie.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            children: [

              Container(
                child: Image.network(movie.backDropPath != null
                    ? "https://image.tmdb.org/t/p/original/${movie.backDropPath}"
                    : 'https://via.placeholder.com/150' ,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height*0.4,
                ),
              ),

              SizedBox(height: MediaQuery.of(context).size.height*0.05),

              Container(
                child: Text(movie.overview, style: TextStyle01,),
              )

            ],
          ),
        ),
      )
    );
  }
}
