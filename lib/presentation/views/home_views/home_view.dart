
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  
  @override
  void initState(){
    super.initState();
     ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
     ref.read(popularMoviesProvider.notifier).loadNextPage();
     
     ref.read(upCommingMoviesProvider.notifier).loadNextPage();
     ref.read(topRatedMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {

    final initialLoading = ref.watch(intialLoadingProvider);
    if(initialLoading) return const FullScreenLoader();

    final slideShowMovies = ref.watch(movieSlideShowProvider);
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    
    final upCommingMovies = ref.watch(upCommingMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);

    // if (nowPlayingMovie.length == 0) return CircularProgressIndicator();


    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppbar(),
            titlePadding: EdgeInsets.zero,
            centerTitle: false,
          ),
        ),

        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index){
              return Column(
        children: [
        //  const CustomAppbar(),
      
          MoviesSlideshow(movies: slideShowMovies),

          MovieHorizontalListview(movies: nowPlayingMovies,
          title: 'En cines',
          subtitle: 'Lunes 20',
          loadNextPage: () => ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
          ),
      
          MovieHorizontalListview(movies: upCommingMovies,
          title: 'Proximamente',
          subtitle: 'En este mes',
          loadNextPage: () => ref.read(upCommingMoviesProvider.notifier).loadNextPage(),
          ),
      
          MovieHorizontalListview(movies: popularMovies,
          title: 'Populares',
          // subtitle: 'En',
          loadNextPage: () => ref.read(popularMoviesProvider.notifier).loadNextPage(),
          ),
      
          MovieHorizontalListview(movies: topRatedMovies,
          title: 'Mejor calificadas',
          subtitle: 'De todos los tiempos',
          loadNextPage: () => ref.read(topRatedMoviesProvider.notifier).loadNextPage(),
          ),

          const SizedBox(height: 50,)
        ],
      );
            },
            childCount: 1
            )
            )

      ]
      
    );
  }
}