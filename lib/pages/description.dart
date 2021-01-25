import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visuales_copy/models/Movie.dart';
import 'package:visuales_copy/provider/the_movie_db_provider.dart';

class Description extends StatelessWidget {
  final Movie _movie;
  final TextStyle infoStyle = TextStyle(
    fontSize: 15,
    color: Colors.black
  );

  Description(this._movie);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this._movie.name),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(top: 10, left: 10),
                width: 150,
                child: Hero(
                  tag: this._movie.id,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image(
                      image: NetworkImage(this._movie.image),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: Get.width * 0.55,
                      child: Text('Título: '+this._movie.original_title, style: infoStyle,)
                    ),
                    Text(this._movie.adult ? 'Solo adultos: Si' : 'Solo adultos: No', style: infoStyle,),
                    Text('Fecha: '+this._movie.release_date, style: infoStyle,),
                    Text('Popularidad: '+this._movie.voteAverage.toString(), style: infoStyle,),
                    Container(
                      width: Get.width * 0.55,
                      child: FutureBuilder(
                        future: TheMovieDbProvider.getGenresById('es-ES', this._movie.genders),
                        builder: (context,AsyncSnapshot<List<String>> snapData) {
                          if(snapData.hasData) {
                            return Text('Géneros: '+snapData.data.map((e) => e).toString(), style: infoStyle,);
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        }
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 20),
            child: Row(
              children: [
                Text('Resumen', style: infoStyle,),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: RichText(
              textAlign: TextAlign.justify,
              text: TextSpan(
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18
                ),
                text: this._movie.overview
              ),
            ),
          )
        ],
      ),
    );
  }
}
