import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../../views/views.dart';

class HomeScreen extends StatelessWidget {
static const name = 'home-screen';
// final Widget childView;
final int pageIndex;

  const HomeScreen({
    super.key,
    required this.pageIndex
    // required this.childView
    });

    final viewRoutes = const <Widget>[
      HomeView(),
      SizedBox(), //<--- Categoria
      FavoritesView()

    ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: childView,
      body: IndexedStack(
        index: pageIndex,
        children: viewRoutes,
      ),
      
      bottomNavigationBar: CustomBottomNavigation(currentIndex: pageIndex),
      // Center(
      //   child: Text(Environment.theMovieFbKey),
      // ),
    );
  }
}
