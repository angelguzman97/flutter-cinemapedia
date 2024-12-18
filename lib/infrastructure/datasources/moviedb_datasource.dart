import 'dart:convert';

import 'package:cinemapedia/config/constans/environment.dart';
import 'package:cinemapedia/domain/datasource/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_details.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';

class MoviedbDatasource extends MoviesDatasource {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.theMovieFbKey,
        'language': 'es-MX'
      }));

  List<Movie> _jsonToMovie(Map<String, dynamic> json) {
    final movieDBResponse = MovieDbResponse.fromJson(json); //Recibimos el Json

//convertimos el objeto
    final List<Movie> movies = movieDBResponse.results
        .where((moviedb) =>
            moviedb.posterPath != 'no-poster') //Filtro Where si es diferente de
        .map((moviedb) => MovieMapper.movieDBToEntity(moviedb))
        .toList();

    return movies;
  }

  ///get NOW PLAYING
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response =
        await dio.get('/movie/now_playing', queryParameters: {'page': page});

    // response.data;
//     final movieDBResponse =
//         MovieDbResponse.fromJson(response.data); //Recibimos el Json

// //convertimos el objeto
//     final List<Movie> movies = movieDBResponse.results
//         .where((moviedb) =>
//             moviedb.posterPath != 'no-poster') //Filtro Where si es diferente de
//         .map((moviedb) => MovieMapper.movieDBToEntity(moviedb))
//         .toList();

    return _jsonToMovie(response.data);
  }

/////get POPULAR
  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response =
        await dio.get('/movie/popular', queryParameters: {'page': page});

    return _jsonToMovie(response.data);
  }

  /////get Upcomming
  @override
  Future<List<Movie>> getUpcomming({int page = 1}) async {
    final response =
        await dio.get('/movie/upcoming', queryParameters: {'page': page});

    return _jsonToMovie(response.data);
  }

  /////get TopRated
  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response =
        await dio.get('/movie/top_rated', queryParameters: {'page': page});

    return _jsonToMovie(response.data);
  }

  @override
  Future<Movie> getMovieById(String id) async {
    final response = await dio.get('/movie/$id');
    if (response.statusCode != 200)
      throw Exception('Movie with id: $id not found');

    final movieDetails = MovieDetails.fromJson(response.data);
    final Movie movie = MovieMapper.movieDetailsToEntity(movieDetails);

    return movie;
  }

  @override
  Future<List<Movie>> searchMovies(String query) async {
    if (query.isEmpty) return [];
    final response =
        await dio.get('/search/movie', queryParameters: {'query': query});

    return _jsonToMovie(response.data);
  }
}
