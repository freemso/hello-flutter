import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:hello_flutter/movie/list/movie.dart';
import 'package:hello_flutter/movie/detail/movie_detail_page.dart';

class MovieListPage extends StatefulWidget {
  @override
  MovieListPageState createState() => new MovieListPageState();
}

class MovieListPageState extends State<MovieListPage> {
  final httpClient = Client();
  List<Movie> movies = [];

  /// Call this method when enter this page
  @override
  void initState() {
    super.initState();
    getMovieListData();
  }

  @override
  Widget build(BuildContext context) {
    var content;
    if (movies.isEmpty) {
      content = new Center(
        child: new CircularProgressIndicator(),
      );
    } else {
      content = new ListView.builder(
        itemCount: movies.length,
        itemBuilder: buildMovieItem
      );
    }

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('近期热映电影'),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.person),
            onPressed: () {
              print('onclick');
            },
          )
        ],
      ),
      body: content,
    );
  }

  /// Jump to another page
  navigateToMovieDetailPage(Movie movie, Object imageTag) {
    Navigator.of(context).push(
        new MaterialPageRoute(
            builder: (BuildContext context) {
              return new MovieDetailPage(movie, imageTag: imageTag);
            }
        )
    );
  }

  /// Get movie list using 豆瓣 API
  getMovieListData() async {
    String response = await httpClient.read(
        'https://api.douban.com/v2/movie/in_theaters?'
            'apikey=0b2bdeda43b5688921839c8ecb20399b&city=%E5%8C%97%E4%BA%AC&'
            'start=0&count=100&client=&udid=');

    setState(() {
      movies = Movie.allFromResponse(response);
    });
  }


  Widget buildMovieItem(BuildContext context, int index) {
    Movie movie = movies[index];

    var movieImage = new Padding(
      padding: const EdgeInsets.only(
        top: 10.0,
        left: 10.0,
        right: 10.0,
        bottom: 10.0,
      ),
      child: new Image.network(
        movie.smallImage,
        width: 100.0,
        height: 120.0,),
    );

    var movieMsg = new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        new Text(
          movie.title,
          textAlign: TextAlign.left,
          style: new TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14.0
          ),
        ),
        new Text('导演：' + movie.director),
        new Text('主演：' + movie.cast),
        new Text('评分：' + movie.average.toString()),
        new Text(
          movie.collectCount.toString() + '人看过',
          style: new TextStyle(
            fontSize: 12.0,
            color: Colors.redAccent,),
        ),
      ],
    );

    var movieItem = new GestureDetector(
      // Click event
      onTap: () => navigateToMovieDetailPage(movie, index),

      child: new Column(

        children: <Widget>[
          new Row(

            children: <Widget>[
              movieImage,
              new Expanded(
                child: movieMsg,
              ),
              const Icon(Icons.keyboard_arrow_right),
            ],
          ),
          new Divider(),
        ],),

    );

    return movieItem;
  }
}