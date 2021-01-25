import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:visuales_copy/provider/the_movie_db_provider.dart';

class Movie {
  int _id;
  String _name;
  List<int> _genders = List<int>();
  String _original_title;
  String _image;
  bool _adult;
  String _overview;
  dynamic _voteAverage;
  String _release_date;
  List<String> _origin_country = List<String>();
  // List<String> _production_companies;


  int get id => _id;

  String get name => _name;

  String get original_title => _original_title;

  String get image => _image;

  bool get adult => _adult;

  String get overview => _overview;

  dynamic get voteAverage => _voteAverage;

  String get release_date => _release_date;

  List<int> get genders => _genders;

  List<String> get origin_country => _origin_country;
  // List<String> get production_companies => _production_companies;

  Movie(
    this._id,
    this._name,
    this._original_title,
    this._genders,
    this._image,
    this._adult,
    this._overview,
    this._voteAverage,
    this._release_date,
    // this._production_countries,
    // this._production_companies
  );

  Movie.fromJson(Map<String, dynamic> json) {
    this._id = json['id'];
    this._name = json['title'];
    this._original_title = json['original_title'] ?? '';
    this._image = 'https://image.tmdb.org/t/p/w200'+json['poster_path'] ?? '';
    this._adult = json['adult'];
    this._overview = json['overview'] ?? '';
    this._voteAverage = json['vote_average'] ?? 0.0;
    this._release_date = json['release_date'] ?? '';
    // print(json);
    for (dynamic gender in json['genre_ids']) {
      this._genders.add(gender ?? '');
    }
    var originCountryTemp = json['origin_country'] ?? ['-'];
    for (dynamic origin_country in originCountryTemp) {
      this._origin_country.add(origin_country);
    }
  }

}