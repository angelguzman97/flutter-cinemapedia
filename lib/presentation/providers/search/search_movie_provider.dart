import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../movies/movies_repository_provider.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchedMoviesProvider = StateNotifierProvider<SearchedMovieNotifier, List<Movie>>((ref) {
  final movieRepository = ref.read(movieRepositoryProvider);
return SearchedMovieNotifier(
  searchMovie: movieRepository.searchMovies, 
  ref: ref
  );
});

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchedMovieNotifier extends StateNotifier<List<Movie>> {
  final SearchMoviesCallback searchMovie;
  final Ref ref;

  SearchedMovieNotifier({
    required this.searchMovie,
    required this.ref
  }):super([]);

  Future<List<Movie>> searchMoviesByQuery(String query) async{
    final List<Movie> movies = await searchMovie(query);
    ref.read(searchQueryProvider.notifier).update((state) => query);
    state = movies;
    return movies;
  }
}