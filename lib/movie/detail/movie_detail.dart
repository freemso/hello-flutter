import 'dart:convert';

import 'package:meta/meta.dart';

class MovieDetail {
  final String title;
  final String average;
  final int collectCount;
  final String smallImage;
  final String director;
  final String cast;
  final String movieId;
  final String summary;

  MovieDetail({
    @required this.title,
    @required this.average,
    @required this.collectCount,
    @required this.smallImage,
    @required this.director,
    @required this.cast,
    @required this.movieId,
    @required this.summary,
  });


  static MovieDetail allFromResponse(String response) {
    return fromMap(json.decode(response));
  }

  static MovieDetail fromMap(Map map) {
    List directors = map['directors'];
    List casts = map['casts'];
    var d = '';
    for (int i = 0; i < directors.length; i++) {
      if (i == 0) {
        d = d + directors[i]['name'];
      } else {
        d = d + '/' + directors[i]['name'];
      }
    }
    var c = '';
    for (int i = 0; i < casts.length; i++) {
      if (i == 0) {
        c = c + casts[i]['name'];
      } else {
        c = c + '/' + casts[i]['name'];
      }
    }
    return new MovieDetail(
      title: map['title'],
      average: map['rating']['average'].toString(),
      collectCount: map['collect_count'],
      smallImage: map['images']['small'],
      director: d,
      cast: c,
      movieId: map['id'],
      summary: map['summary'],
    );
  }
}