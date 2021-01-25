import 'package:dio/dio.dart';
import 'package:visuales_copy/models/Movie.dart';

class TheMovieDbProvider {

  static String ApiKey = 'd66f01ce5bbc1a59e92e5e9e1ca65956';
  static String dominio = 'https://api.themoviedb.org/3/';

  static Future<Movie> getMovie(String id, String language) async {
    try {
      Response response = await Dio().get(dominio+'movie/$id',
        queryParameters: {
          'api_key' : ApiKey,
          'language' : language
        }
      );
      return Movie.fromJson(response.data);
    } catch (e) {
      print(e);
    }
  }

  static Future<List<Movie>> getPopularsMovies(String language, int page) async {
    List<Movie> movies = List<Movie>();
    try {
      Response response = await Dio().get(dominio+'movie/popular/',
        queryParameters: {
          'api_key' : ApiKey,
          'language' : language,
          'page' : 1
        }
      );
      for (Map<String, dynamic> movieJson in response.data['results']) {
        Movie movie = Movie.fromJson(movieJson);
        movies.add(movie);
      }
      return movies;
    } catch (e) {
      print(e);
    }
  }

  static Future<List<Movie>> getPopularsSeries(String language) async {
  List<Movie> movies = List<Movie>();
  try {
   Response response = await Dio().get(dominio+'tv/popular/',
     queryParameters: {
       'api_key' : ApiKey,
       'language' : language
     }
   );
   for (Map<String, dynamic> movieJson in response.data['results']) {
     Movie movie = Movie.fromJson(movieJson);
     movies.add(movie);
   }
   return movies;
  } catch (e) {
   print(e);
  }
  }

  static Future<List<String>> getGenres(String language) async {
    List<String> genres = List<String>();
    try {
     Response response = await Dio().get(dominio+'genre/movie/list',
       queryParameters: {
         'api_key' : ApiKey,
         'language' : language
       }
     );
     for (Map<String, dynamic> data in response.data['results']) {
       genres.add(data['name']);
     }
     return genres;
    } catch (e) {
     print(e);
    }
  }

  static Future<List<String>> getGenresById(String language, List<int> ids) async {
    List<String> genres = List<String>();
    try {
      Response response = await Dio().get(dominio+'genre/movie/list',
        queryParameters: {
          'api_key' : ApiKey,
          'language' : language
        }
      );
      for (Map<String, dynamic> data in response.data['genres']) {
        if (ids.contains(data['id']))
          genres.add(data['name']);
      }
      print(genres);
      return genres;
    } catch (e) {
      print(e);
    }
  }

}