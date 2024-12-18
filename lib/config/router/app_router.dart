import 'package:cinemapedia/presentation/screens/movies/home_screen.dart';
import 'package:cinemapedia/presentation/screens/movies/movie_screen.dart';
import 'package:cinemapedia/presentation/views/home_views/favorites_view.dart';
import 'package:cinemapedia/presentation/views/views.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(initialLocation: '/', routes: [

  ShellRoute(
    builder: (context, state, child){
      return HomeScreen(childView: child);
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          return const HomeView();
        },
        routes: [
          GoRoute(
            path: 'movie/:id',
            name: MovieScreen.name,
            builder: (context, state) {
              final movieId = state.pathParameters['id'] ?? 'no-id';
              return MovieScreen(movieId: movieId);
            }),
        ]
        ),

        //Favorites
        GoRoute(
        path: '/favorites',
        builder: (context, state) {
          return const FavoritesView();
        },
        )
    ]
    )

  //Rutas pasre/hijo
  // GoRoute(
  //     path: '/',
  //     name: HomeScreen.name,
  //     builder: (context, state) => const HomeScreen(childView: HomeView(),),
  //     routes: [
        // GoRoute(
        //     path: 'movie/:id',
        //     name: MovieScreen.name,
        //     builder: (context, state) {
        //       final movieId = state.pathParameters['id'] ?? 'no-id';
        //       return MovieScreen(movieId: movieId);
        //     }),
  //     ]),
]);
