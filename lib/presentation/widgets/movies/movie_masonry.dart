import 'package:cinemapedia/domain/domain.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MovieMasonry extends StatefulWidget {
  final List<Movie> movies;
  final VoidCallback? loadNextPage;

  const MovieMasonry({
    required this.movies,  
    this.loadNextPage, 
    super.key,});

  @override
  State<MovieMasonry> createState() => _MovieMasonryState();
}

class _MovieMasonryState extends State<MovieMasonry> {
  final scrollController = ScrollController();
  //TODO: initState
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener((){
      if (widget.loadNextPage == null) return;

      if ((scrollController.position.pixels + 200) >=
          scrollController.position.maxScrollExtent) {
        widget.loadNextPage!();
      }
    });
    
  }
  @override
  void dispose() {
    // TODO: implement dispose
    scrollController.dispose();
    super.dispose();

  }

  //TODO: dispose

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: MasonryGridView.count(
        controller: scrollController,
        scrollDirection: Axis.vertical,
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        itemCount: widget.movies.length,
        itemBuilder: (context, index) {
          if(index == 1){
            return Column(
              children: [
                const SizedBox(height: 40,),
                MoviePosterLink(movie: widget.movies[index])
              ],
            );
          }
          return MoviePosterLink(
            movie: widget.movies[index]
          );
        },
      ),
    );
  }
}