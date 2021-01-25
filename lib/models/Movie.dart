import 'dart:convert';

class Movie {
  int _id;
  String _name;
  String _image;



  int get id => _id;
  String get name => _name;
  String get image => _image;

  Movie(this._id, this._name, this._image);

  Movie.fromJson(Map<String, dynamic> json){
    this._id = json['id'];
    this._name = json['title'];
    this._image = 'https://image.tmdb.org/t/p/w500'+json['poster_path'];
  }

}