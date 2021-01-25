import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visuales_copy/models/Movie.dart';
import 'package:visuales_copy/pages/description.dart';
import 'package:visuales_copy/provider/the_movie_db_provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Visuales Copy probando ci cd 3'),
        actions: [
          IconButton(
            icon: Icon(Icons.search_rounded),
            onPressed: () {
              //TODO hacer buscador
            }
          )
        ],
      ),
      body: getBody(),
      drawer: SafeArea(
        child: Drawer(
          child: Column(
            children: [
              ListTile(
                title: Text('Películas'),
              ),
              Divider(thickness: 1,),
              ListTile(
                title: Text('Series'),
              ),
              Divider(thickness: 1,),
              ListTile(
                title: Text('Anime'),
              ),
              Divider(thickness: 1,),
              ListTile(
                title: Text('Doramas'),
              ),
              Divider(thickness: 1,),
              ListTile(
                title: Text('Documentales'),
              ),
              Divider(thickness: 1,),
            ],
          ),
        ),
      ),
    );
  }

  getBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 10,),
          Text('Películas populares',
            style: TextStyle(
              fontSize: 20
            ),
          ),
          SizedBox(height: 10,),
          getPeliculasPopulares(),
          SizedBox(height: 10,),
          Text('Series populares',
            style: TextStyle(
              fontSize: 20
            ),
          ),
          SizedBox(height: 10,),
          getSeriespopulares(),
        ],
      )
    );
  }

  getPeliculasPopulares() {
    return FutureBuilder(
      future: TheMovieDbProvider.getPopularsMovies('es-ES', 1),
      builder: (BuildContext context,AsyncSnapshot<List<Movie>> snapData) {
        if(snapData.hasData) {
          return CarouselSlider(
            options: CarouselOptions(
              height: 300.0,
              // disableCenter: true,
              viewportFraction: .5,
              // enlargeCenterPage: true,
            ),
            items: snapData.data.map((movie) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    // width: MediaQuery.of(context).size.width,
                    width: 200,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    // child: Text(movie.name, style: TextStyle(fontSize: 16.0),)
                    child: Hero(
                      tag: movie.id,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Material(
                          type: MaterialType.transparency,
                          child: InkResponse(
                            onTap: () {
                              Get.to(Description(movie));
                            },
                            child: FadeInImage(
                              fit: BoxFit.cover,
                              image: Image.network(movie.image).image,
                              placeholder: AssetImage('assets/loading.gif'),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      }
    );
  }

  getSeriespopulares() {
    return FutureBuilder(
      future: TheMovieDbProvider.getPopularsSeries('es-ES'),
      builder: (BuildContext context,AsyncSnapshot<List<Movie>> snapData) {
        if(snapData.hasData) {
          return CarouselSlider(
            options: CarouselOptions(
              height: 300.0,
              // disableCenter: true,
              viewportFraction: .5,
              // enlargeCenterPage: true,
            ),
            items: snapData.data.map((movie) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    // width: MediaQuery.of(context).size.width,
                    width: 200,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    // child: Text(movie.name, style: TextStyle(fontSize: 16.0),)
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: FadeInImage(
                        fit: BoxFit.cover,
                        image: Image.network(movie.image).image,
                        placeholder: AssetImage('assets/loading.gif'),
                      )
                    ),
                  );
                },
              );
            }).toList(),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      }
    );
  }
}
