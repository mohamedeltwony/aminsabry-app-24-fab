import 'package:streamit_flutter/models/movie_episode/movie_data.dart';

class GenreResponse{
  List<GenreData>? genreDataList;

  GenreResponse({this.genreDataList});
  factory GenreResponse.fromJson(Map<String, dynamic> json){
    return GenreResponse(
      genreDataList:json['data'] != null ? (json['data'] as List).map((i) =>GenreData.fromJson(i)).toList():null,
    );
  }



}
class GenreData {
  int? id;
  String? name;
  String? slug;
  String? genreImage;

  GenreData({this.id, this.name, this.slug, this.genreImage});

  factory GenreData.fromJson(Map<String, dynamic> json) {
    return GenreData(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      genreImage: json['genre_image'] != false ? json['genre_image'] : null,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();

    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['genre_image'] = this.genreImage;

    return data;
  }
}

class GenreMovieList {
  List<MovieData>? genreMovieList;

  GenreMovieList({this.genreMovieList});

  factory GenreMovieList.fromJson(Map<String, dynamic> json) {
    return GenreMovieList(
      genreMovieList: json['data'] != null ? (json['data'] as List).map((e) => MovieData.fromJson(e)).toList() : null,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();

    data['data'] = this.genreMovieList;

    return data;
  }
}
